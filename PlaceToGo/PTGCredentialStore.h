//
//  PTGCredentialStore.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/12/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTGCredentialStore : NSObject

+ (NSString *) getAccessToken;
+ (void) setAccessToken:(NSString *) accessToken;
+ (BOOL) isThereAuthenticatedUser;
+ (void) deleteAccessToken;

@end
