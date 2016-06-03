 //
//  UIView+ViewController.h
//  ThouTool
//
//  Created by thou on 15/11/4.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

//使视图可以寻找到自己的所在控制器
- (UIViewController *)viewController;

//寻找当前视图中的第一响应者
- (UIView *)findFirstResponder;

@end
