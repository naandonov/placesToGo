//
//  PTGNetworkManager.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGNetworkManager.h"

static NSString *const kImagesDirectoryName = @"Image";

@interface PTGNetworkManager ()

@property (nonatomic, strong) NSURLSession *session;


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

- (void) taskWithRequest:(NSURLRequest *) request completion: (void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}

- (void) downloadImageFromURL:(NSURL *)url andImageID:(NSString *)imageID completion:(void(^)(NSURL *newFileLocation, NSError *imageError))completion{
    __block NSString *documentsDirectory = nil;
    NSArray *paths = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:kImagesDirectoryName];
    if(![imageID pathExtension]){
        imageID = [documentsDirectory stringByAppendingPathComponent:[imageID stringByAppendingPathExtension:@"png"]];
    }else{
        imageID = [documentsDirectory stringByAppendingPathComponent:imageID];
    }
    NSURL *newLocation = [NSURL fileURLWithPath:imageID];
    NSURLSessionDownloadTask *downloadTask = nil;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:imageID]){
        if(![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory]){
            NSError *createError = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&createError];
        }
        downloadTask = [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *moveError = nil;
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:newLocation error:&moveError];
            if(completion){
                completion(newLocation,error);
            }
        }];
    }
    if(!downloadTask){
        if(completion){
            completion(newLocation, nil);
        }
    }else{
        [downloadTask resume];
    }
}

@end