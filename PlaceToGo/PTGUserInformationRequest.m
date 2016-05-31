//
//  PTGUserInfoRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/25/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGUserInformationRequest.h"
#import "PTGNetworkManager.h"
#import "PTGCoreDataHandler.h"

NSString *const kUserSearchEndpoint = @"https://api.foursquare.com/v2/users";
NSString *const kUserSelf = @"self";
NSString *const kResponseKey = @"response";
NSString *const kUserKey = @"user";
NSString *const kFirstNameKey = @"firstName";
NSString *const kLastNameKey = @"lastName";
NSString *const kEmailKey = @"email";
NSString *const kPhotoKey = @"photo";
NSString *const kPhotoPrefixKey = @"prefix";
NSString *const kPhotoSize = @"100x100";
NSString *const kPhotoSuffixKey = @"suffix";
NSString *const kImagePath = @"imagePath";
NSString *const kContactKey = @"contact";
NSInteger const httpResponse200 = 200;
@implementation PTGUserInformationRequest

- (instancetype)initWithUserID:(NSString *)userID{
    NSURL *userRequestURL = [NSURL URLWithString:kUserSearchEndpoint];
    if(userID){
        userRequestURL = [userRequestURL URLByAppendingPathComponent:userID];
    }else{
        userRequestURL = [userRequestURL URLByAppendingPathComponent:kUserSelf];
    }
    NSLog(@"%@",userRequestURL);
    self = [super initWithURL:userRequestURL];
    
    
    return self;
}


- (void)getUserInformationWithCompletion:(void(^)(NSDictionary *dict, NSError *error))completion{
    [[PTGNetworkManager sharedManager] taskWithRequest:[[PTGUserInformationRequest alloc] initWithUserID:nil] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (error || ((NSHTTPURLResponse*)response).statusCode != httpResponse200) {
            completion(nil,error);
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *responseJSON = [json valueForKey:kResponseKey];
        NSDictionary *userJSON = [responseJSON valueForKey:kUserKey];
        NSString *firstName =[userJSON valueForKey:kFirstNameKey];
        NSString *lastName =[userJSON valueForKey:kLastNameKey];
        NSString *email = [[userJSON valueForKey:kContactKey] valueForKey:kEmailKey];
        NSDictionary *photo = [userJSON valueForKey:kPhotoKey];
        NSString *imagePath = [photo valueForKey:kPhotoPrefixKey];
        imagePath = [imagePath stringByAppendingPathComponent:kPhotoSize];
        imagePath = [imagePath stringByAppendingPathComponent:[photo valueForKey:kPhotoSuffixKey]];
        [[PTGNetworkManager sharedManager] downloadImageFromURL:[NSURL URLWithString:imagePath] andImageID:[photo valueForKey:kPhotoSuffixKey] completion:^(NSURL *newFileLocation, NSError *imageError) {
            NSMutableDictionary *userInformationDictionary = nil;
            
            NSString *newIconPath = newFileLocation.absoluteString;
            newIconPath = [[newIconPath stringByDeletingLastPathComponent] lastPathComponent];
            newIconPath = [newIconPath stringByAppendingPathComponent:[newFileLocation.absoluteString lastPathComponent]];
            userInformationDictionary = [@{kFirstNameKey:firstName,
                                          kLastNameKey:lastName,
                                          kEmailKey:email,
                                          kImagePath:newIconPath} mutableCopy];
            
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(userInformationDictionary,error);
                }
            });
        }];
    }];
}

@end