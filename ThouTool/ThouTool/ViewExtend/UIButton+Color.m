//
//  UIButton+Color.m
//  ThouTool
//
//  Created by thou on 16/3/7.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "UIButton+Color.h"

@implementation UIButton (Color)

- (void)setButtonColor:(UIColor *)colorNormal
{
    // 设置背景颜色
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [colorNormal set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

- (void)setButtonColor:(UIColor *)colorNormal highLightColor:(UIColor *)colorHightlighted
{
    // 设置背景颜色
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [colorNormal set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:img forState:UIControlStateNormal];
    
    // 设置高亮颜色
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
}

@end
