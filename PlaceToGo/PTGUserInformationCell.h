//
//  PTGUserInformationCell.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/23/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGLoginButton.h"


@interface PTGUserInformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet PTGLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
