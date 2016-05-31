//
//  PTGUserInformationCell.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/23/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PTGUserInformationCell : UITableViewCell

@property (nonatomic, strong, setter=setName:) NSString *name;
@property (nonatomic, strong, setter=setMail:) NSString *mail;
@property (nonatomic, strong, setter=setImagePath:) NSString *avatarImagePath;


@end
