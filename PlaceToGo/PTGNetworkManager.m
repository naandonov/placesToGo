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



@end
