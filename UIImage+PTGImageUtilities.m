//
//  UIImage+EMAImageUtilities.m
//  Employee Assigner
//
//  Created by Veselin Cholakov on 4/14/16.
//  Copyright © 2016 Veselin Cholakov. All rights reserved.
//

#import "UIImage+PTGImageUtilities.h"

@implementation UIImage (PTGImageUtilities)

- (UIImage*)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
