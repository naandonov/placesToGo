//
//  PTGRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/16/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGBaseRequest.h"
#import "PTGCredentialStore.h"
#import "APIConstants.h"

@implementation PTGBaseRequest

- (instancetype)initWithURL:(NSURL *) url{
    self = [super initWithURL:url];
    if(self){
        NSDictionary *baseParameters = nil;
        if([PTGCredentialStore isThereAuthenticatedUser]){
            baseParameters = @{@"oauth_token":[PTGCredentialStore getAccessToken],@"v":foursquareAPIVersion};
            [self appendURLQueryWithQueries:baseParameters];
        } else {
            baseParameters = @{@"v":foursquareAPIVersion,@"client_id":foursquareClientID,@"client_secret":foursquareClientSecret};
            [self appendURLQueryWithQueries:baseParameters];
        }
    }
    return self;
}

- (void) appendURLQueryWithQueries:(NSDictionary *) parametersDictionary{
    if(parametersDictionary.count > 0){
        NSURLComponents *comps = [NSURLComponents componentsWithURL:self.URL resolvingAgainstBaseURL:YES];
        NSMutableArray *currentQueriesArray = nil;
        if(comps.queryItems.count > 0){
            currentQueriesArray = [comps.queryItems mutableCopy];
        }else{
            currentQueriesArray = [[NSMutableArray alloc] init];
        }
        NSArray *allKeys = parametersDictionary.allKeys;
        for (NSString *key in allKeys) {
            NSURLQueryItem *query = [NSURLQueryItem queryItemWithName:key
                                                                value:[parametersDictionary[key] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
            [currentQueriesArray addObject:query];
        }
        comps.queryItems = currentQueriesArray;
        self.URL = comps.URL;
        NSLog(@"%@",self.URL);
    }
}


@end