//
//  UITableViewCell+Background.h
//  ThouTool
//
//  Created by thou on 16/5/25.
//  Copyright © 2016年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewNormal.h"

#pragma mark - 常用颜色
#define kCellEvenColor UIColorFromRGB(0xf9f9f9)
#define kCellOddColor UIColorFromRGB(0xffffff)

@interface UITableViewCell (Background)

- (void)backgroundGradient:(NSIndexPath *)indexPath;

- (void)backgroundGradient:(NSIndexPath *)indexPath withOddColor:(UIColor *)oddColor andEvenColor:(UIColor *)evenColor;

@end
