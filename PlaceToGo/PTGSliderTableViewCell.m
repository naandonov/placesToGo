//
//  PTGSliderTableViewCell.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/26/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGSliderTableViewCell.h"

@interface PTGSliderTableViewCell()


@end


NSInteger const stepSize = 5;

@implementation PTGSliderTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.venuesCountSlider addTarget:self action:@selector(setCountSliderValue:) forControlEvents:UIControlEventValueChanged];
}


- (IBAction)setCountSliderValue:(UISlider *)sender{
    NSInteger value = (NSInteger)sender.value;
    value = value - value % stepSize;
    sender.value = value;
    self.countValue = value;
}

- (void)setCountValue:(NSInteger)countValue{
    if (countValue >= self.venuesCountSlider.minimumValue) {
        _countValue = countValue;
    }else{
        _countValue = self.venuesCountSlider.minimumValue;
    }
    if([self.delegate respondsToSelector:@selector(setCountLimit:)]){
        [self.delegate setCountLimit:_countValue];
    }
    self.countValueLabel.text  = [NSString stringWithFormat:@"%ld",_countValue];
    self.venuesCountSlider.value = _countValue;
}

@end
