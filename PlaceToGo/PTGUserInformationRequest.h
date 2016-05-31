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




extern NSString *const kFirstNameKey;
extern NSString *const kLastNameKey;
extern NSString *const kEmailKey;
extern NSString *const kPhotoKey;
extern NSString *const kPhotoPrefixKey;
extern NSString *const kPhotoSize;
extern NSString *const kPhotoSuffixKey;
extern NSString *const kImagePath;


- (instancetype)initWithUserID:(NSString *)userID;
- (void)getUserInformationWithCompletion:(void(^)(NSDictionary *dict, NSError *error))completion;

@end
