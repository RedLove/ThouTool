//
//  UIView+ViewController.m
//  ThouTool
//
//  Created by thou on 15/11/4.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UIView *)findFirstResponder{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

@end
