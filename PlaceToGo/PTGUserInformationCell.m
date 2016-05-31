//
//  PTGUserInformationCell.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/23/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGUserInformationCell.h"
#import "UIImage+PTGImageUtilities.h"

@interface PTGUserInformationCell () 
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@end


@implementation PTGUserInformationCell

-(instancetype)init{
    self = [super init];
 
    return self;
}

- (void)setName:(NSString *) newValue{
    self.nameLabel.text = newValue;
}

- (void)setMail:(NSString *) newValue{
    self.mailLabel.text = newValue;
}

- (void)setImagePath:(NSString *)avatarImagePath{
    UIImage *avatarImage = [UIImage imageWithContentsOfFile:avatarImagePath];
    avatarImage = [avatarImage scaleToSize:self.userAvatarImageView.frame.size];
    self.userAvatarImageView.clipsToBounds = YES;
    self.userAvatarImageView.image = avatarImage;
    self.userAvatarImageView.layer.cornerRadius = avatarImage.size.height/2;
}
@end
