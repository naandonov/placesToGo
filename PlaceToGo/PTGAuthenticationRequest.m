//
//  PTGAuthenticationRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/20/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGAuthenticationRequest.h"
#import "APIConstants.h"

NSString *const kFoursquareAuthenticationURL = @"https://foursquare.com/oauth2/authenticate?client_id=S1H4UTLND430NCWPL0HNTAKF2F0NKSZZM2TEJUXWXOEJWFJ1&response_type=token&redirect_uri=ptgaccess://redirect";

@implementation PTGAuthenticationRequest

- (instancetype)init{
    NSURL *authenticationURL = [NSURL URLWithString:kFoursquareAuthenticationURL];
    self = [super initWithURL:authenticationURL];
    self.HTTPMethod = kFoursquareHttpGET;
    return self;
}


@end
