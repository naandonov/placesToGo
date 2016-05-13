//
//  PTGVenueRequest.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/13/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGVenueRequest.h"
#import "PTGNetworkManager.h"

@interface PTGVenueRequest ()

@end


@implementation PTGVenueRequest

- (instancetype)initWithURL:(NSURL *) url andParameters:(NSDictionary *) params{
    
    NSURLComponents *comps = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    
    comps.queryItems = @[];
    self = [super initWithURL:comps.URL];
    return self;
}

- (void)initializeSession{
    [[[PTGNetworkManager sharedManager] taskWithRequest:self] resume];
}


@end