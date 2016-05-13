//
//  PTGCredentialStore.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGCredentialStore.h"

@implementation PTGCredentialStore
static NSString *accessToken;
NSString *const serviceName = @"";
NSString *const clientID = @"S1H4UTLND430NCWPL0HNTAKF2F0NKSZZM2TEJUXWXOEJWFJ1";
NSString *const clientSecret = @"PT15GJTFW003NO2PWKQ5BA3N1LB22BAM4GS0A1YCLRRPKI3K";

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
