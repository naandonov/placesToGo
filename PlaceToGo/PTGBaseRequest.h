//
//  PTGRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/16/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTGBaseRequest : NSMutableURLRequest

- (void) appendURLQueryWithQueries:(NSDictionary *) params;
- (instancetype)initWithURL:(NSURL *) url;

@end
