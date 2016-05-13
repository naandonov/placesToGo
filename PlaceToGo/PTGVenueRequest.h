//
//  PTGVenueRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/13/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTGVenueRequest : NSURLRequest
- (instancetype)initWithURL:(NSURL *) url andParameters:(NSDictionary *) params;
- (void)initializeSession;
@end
