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
- (void) taskWithRequest:(NSURLRequest *) request completion: (void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (void) downloadImageFromURL:(NSURL *)url andImageID:(NSString *)imageID completion:(void(^)(NSURL *newFileLocation, NSError *imageError))completion;

@end
