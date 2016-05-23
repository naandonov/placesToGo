//
//  PTGVenueRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/13/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGVenueRequest.h"
#import "PTGNetworkManager.h"
#import <SSKeychain/SSKeychain.h>
#import "APIConstants.h"
@interface PTGVenueRequest ()

@end


@implementation PTGVenueRequest

- (instancetype)initWithURL:(NSURL *) url andParameters:(NSDictionary *) params{
    self = [super initWithURL:[NSURL URLWithString:kFoursquareVenueEndpoint]];
    [self appendURLQueryWithQueries:params];
    return self;
}



- (void)initializeSessionWithCompletition:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completion{
    [[PTGNetworkManager sharedManager] taskWithRequest:self completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"I'm doing something here...\n\n\n");
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", [[[dictionary objectForKey:@"response"] objectForKey:@"categories"] valueForKey:@"name"]);
        
        if (completion) {
            completion(data,response,error);
        }
    }];
}



@end