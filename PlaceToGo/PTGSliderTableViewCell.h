//
//  PTGSliderTableViewCell.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/26/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTGSliderTableViewCellDelegate <NSObject>

- (void)setCountLimit:(NSInteger) count;
- (void)setRadius:(NSInteger) radius;

@end

@interface PTGSliderTableViewCell : UITableViewCell

@property (weak, nonatomic) id<PTGSliderTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (assign, nonatomic, setter=setCountValue:) NSInteger countValue;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;

@end