//
//  PTGCategoriesRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/17/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGBaseRequest.h"

@interface PTGCategoriesRequest : PTGBaseRequest

- (instancetype)initWithParameters:(NSDictionary *) params;
- (void)initializeSessionWithCompletition:(void(^)(NSArray <NSDictionary *> *dict, NSError *error))completionHandler;

@end