//
//  PTGCategoriesRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGBaseRequest.h"

@interface PTGCategoriesRequest : PTGBaseRequest
extern NSString *const nameKey;
extern NSString *const idKey;
extern NSString *const iconPathKey;

- (instancetype)initRequest;
- (void)getCategoriesWithCompletion:(void(^)(NSArray <NSDictionary *> *dict, NSError *error))completionHandler;

@end