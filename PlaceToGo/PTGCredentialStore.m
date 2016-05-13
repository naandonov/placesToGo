//
//  PTGCredentialStore.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCredentialStore.h"
static NSString *accessToken;

@implementation PTGCredentialStore

#pragma mark - User check

+ (BOOL) isThereAuthenticatedUser{
    return YES;
}

#pragma mark - AccessToken manipulation

+ (NSString *) getAccessToken{
    return accessToken;
}

+ (void) setAccessToken:(NSString *) token{
    accessToken = token;
}

+ (void) deleteAccessToken{
    accessToken = nil;
}

@end
