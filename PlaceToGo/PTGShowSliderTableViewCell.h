//
//  PTGPTGShowCountSliderTableViewCell.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 6/1/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PTGShowSliderTableViewCellDelegate <NSObject>

- (void)enableSlider:(NSInteger)cellType;
- (void)isShowClosedEnabled;

@end


@interface PTGShowSliderTableViewCell : UITableViewCell

@property (weak, nonatomic) id<PTGShowSliderTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UISwitch *showSliderCellSwitch;
@property (assign, nonatomic) NSInteger cellType;

@end
