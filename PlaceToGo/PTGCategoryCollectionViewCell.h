//
//  PTGCategoryCollectionViewCell.h
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/19/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGCategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@end
