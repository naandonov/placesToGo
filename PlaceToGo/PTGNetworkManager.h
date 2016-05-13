//
//  PTGNetworkManager.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTGNetworkManager : NSObject

+ (PTGNetworkManager *) sharedManager;
- (NSURLSessionTask *) taskWithRequest:(NSURLRequest *) request;

@end
