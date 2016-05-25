//
//  PTGUserInformationCell.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/23/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGUserInformationCell.h"
@interface PTGUserInformationCell () <PTGLoginButtonDelegate>

@end


@implementation PTGUserInformationCell

-(instancetype)init{
    self = [super init];
    self.loginButton.delegate = self;
    self.loginButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    return self;
}


@end
