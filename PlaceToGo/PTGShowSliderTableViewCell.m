//
//  PTGPTGShowCountSliderTableViewCell.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 6/1/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "PTGShowSliderTableViewCell.h"

NSInteger const kPTGShowClosedVenuesFilterItem = 0;

@implementation PTGShowSliderTableViewCell

- (IBAction)enableSliderCell:(UISwitch *)sender {
    if(self.cellType == kPTGShowClosedVenuesFilterItem){
        if ([self.delegate respondsToSelector:@selector(isShowClosedEnabled)]) {
            [self.delegate isShowClosedEnabled];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(enableSlider:)]) {
            [self.delegate enableSlider:self.cellType];
        }
    }
}

@end
