//
//  UIColor+PTGColor.m
//  PlaceToGo
//
//  Created by Veselin Cholakov on 5/20/16.
//  Copyright © 2016 Nikolay Andonov. All rights reserved.
//

#import "UIColor+PTGColor.h"

@implementation UIColor (PTGColor)

+ (UIColor *)lightBlueColor{
    UIColor *color = [UIColor colorWithRed:101.0f/255.0f green:181.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    return color;
}

+ (UIColor *)darkBlueColor{
    UIColor *color = [UIColor colorWithRed:40.0f/255.0f green:81.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
    return color;
}

+ (UIColor *) highlightBlueColor{
   return [UIColor colorWithRed:70.0f/255.0f green:130.0f/255.0f blue:198.0f/255.0f alpha:1.0f];
}

@end