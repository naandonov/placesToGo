//
//  PTGVenueRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/13/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTGBaseRequest.h"

@interface PTGVenueRequest : PTGBaseRequest
- (instancetype)initWithURL:(NSURL *) url andParameters:(NSDictionary *) params;
- (void)initializeSessionWithCompletition:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completition;
@end
