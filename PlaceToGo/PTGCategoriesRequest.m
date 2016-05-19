//
//  PTGCategoriesRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCategoriesRequest.h"
#import "PTGNetworkManager.h"
#import "APIConstants.h"

static NSString *const foursquareCategoryEndpointExtension = @"categories";

@implementation PTGCategoriesRequest



- (instancetype)initWithParameters:(NSDictionary *) params{
    NSString *urlString = [foursquareVenueEndpoint stringByAppendingPathComponent:foursquareCategoryEndpointExtension];
    
    self = [super initWithURL:[NSURL URLWithString:urlString]];
    
    self.HTTPMethod = foursquareHttpGET;
    [self appendURLQueryWithQueries:params];
    return self;
}



- (void)initializeSessionWithCompletition:(void(^)(NSArray <NSDictionary *> *dict, NSError *error))completionHandler{
    [[PTGNetworkManager sharedManager] taskWithRequest:self completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *categoriesArray = [[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"response"] valueForKey:@"categories"];
        NSMutableArray <NSDictionary *> *categoriesDictionary = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in categoriesArray) {
            
            NSDictionary *icon = [dict valueForKey:@"icon"] ;
            NSString *iconPath = [NSString stringWithFormat:@"%@%@%@",[icon valueForKey:@"prefix"],foursquareIconSize,[icon valueForKey:@"suffix"]];
            NSString *categoryID = [dict valueForKey:@"id"];
            [[PTGNetworkManager sharedManager] downloadImageFromURL:[NSURL URLWithString:iconPath] andImageID:categoryID completion:^(NSURL *newFileLocation, NSError *imageError) {
                
                NSString *newIconPath = newFileLocation.absoluteString;
                [categoriesDictionary addObject:@{@"name":[dict valueForKey:@"name"],
                                                  @"id":categoryID,
                                                  @"iconPath":newIconPath}];
                if (completionHandler) {
                    completionHandler(categoriesDictionary,error);
                }
            }];
        }
    }];
}



@end
