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
NSString *const nameKey = @"name";
NSString *const idKey = @"idKey";
NSString *const iconPathKey = @"iconPath";
@implementation PTGCategoriesRequest



- (instancetype)initRequest{
    NSString *urlString = [foursquareVenueEndpoint stringByAppendingPathComponent:foursquareCategoryEndpointExtension];
    
    self = [super initWithURL:[NSURL URLWithString:urlString]];
    self.HTTPMethod = foursquareHttpGET;
    return self;
}

- (void)getCategoriesWithCompletion:(void(^)(NSArray <NSDictionary *> *dict, NSError *error))completionHandler{
    [[PTGNetworkManager sharedManager] taskWithRequest:self completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *categoriesArray = [[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"response"] valueForKey:@"categories"];
        NSMutableArray <NSDictionary *> *categoriesDictionary = [[NSMutableArray alloc] init];
        dispatch_group_t group = dispatch_group_create();
        
        for (NSDictionary *dict in categoriesArray) {
            
            NSDictionary *icon = [dict valueForKey:@"icon"] ;
            NSString *iconPath = [NSString stringWithFormat:@"%@%@%@",[icon valueForKey:@"prefix"],foursquareIconSize,[icon valueForKey:@"suffix"]];
            NSString *categoryID = [dict valueForKey:@"id"];
            
            dispatch_group_enter(group);
            [[PTGNetworkManager sharedManager] downloadImageFromURL:[NSURL URLWithString:iconPath] andImageID:categoryID completion:^(NSURL *newFileLocation, NSError *imageError) {
                
                NSString *newIconPath = newFileLocation.absoluteString;
                newIconPath = [[newIconPath stringByDeletingLastPathComponent] lastPathComponent];
                newIconPath = [newIconPath stringByAppendingPathComponent:[newFileLocation.absoluteString lastPathComponent]];
                [categoriesDictionary addObject:@{nameKey:[dict valueForKey:nameKey],
                                                  idKey:categoryID,
                                                  iconPathKey:newIconPath}];
                dispatch_group_leave(group);
            }];
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                NSLog(@"thread");
                if (completionHandler) {
                    completionHandler(categoriesDictionary,error);
                }
        });
    }];
}



@end
