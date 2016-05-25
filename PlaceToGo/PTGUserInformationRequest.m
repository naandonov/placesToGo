//
//  PTGUserInfoRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/25/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGUserInformationRequest.h"

NSString *const kUserSearchEndpoint = @"https://api.foursquare.com/v2/users";
NSString *const kUserSelf = @"self";

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



@end
