//
//  PTGCredentialStore.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCredentialStore.h"
#import "SSKeychain/SSKeychain.h"
#import "APIConstants.h"


static NSString *accessToken;
static NSString *const accountName = @"PlaceToGoAccountName";
static NSString *const serviceName = @"PlaceToGoAccountService";

@implementation PTGCredentialStore

#pragma mark - User check

+ (BOOL) isThereAuthenticatedUser{
    if ([self getAccessToken]) {
        return YES;
    }
    return NO;
}

#pragma mark - AccessToken manipulation

+ (NSString *) getAccessToken{
    return accessToken;
}

+ (void) setAccessToken:(NSString *) token{
    [SSKeychain setPassword:token forService:serviceName account:accountName];
    accessToken = token;
}

+ (void) deleteAccessToken{
    [SSKeychain deletePasswordForService:serviceName account:accountName];
    accessToken = nil;
}

@end
