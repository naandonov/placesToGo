//
//  PTGUserInfoRequest.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/25/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGBaseRequest.h"


@interface PTGUserInformationRequest : PTGBaseRequest

- (instancetype)initWithUserID:(NSString *)userID;

@end
