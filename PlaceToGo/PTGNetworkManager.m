//
//  PTGNetworkManager.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGNetworkManager.h"

@interface PTGNetworkManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation PTGNetworkManager

#pragma mark - Shared manager
+ (PTGNetworkManager *) sharedManager{
    static PTGNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (NSURLSession *)session{
    if(_session){
        return _session;
    }
    
    _session = [NSURLSession sharedSession];
    return _session;
}

- (NSURLSessionTask *) taskWithRequest:(NSURLRequest *) request{
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
    }];
    return dataTask;
}

@end
