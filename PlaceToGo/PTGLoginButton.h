//
//  PTGLoginButton.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/23/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PTGLoginButtonDelegate <NSObject>



@end

@class PTGUserInformationCell;

@interface PTGLoginButton : UIButton
@property (nonatomic, weak) PTGUserInformationCell<PTGLoginButtonDelegate> *delegate;
@end
