//
//  UITextInputExtendRange.h
//  Keyboard
//
//  Created by thou on 16/3/8.
//  Copyright © 2016年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITextInputExtendRange <UITextInput>

- (NSRange)selectedRange;
- (void) setSelectedRange:(NSRange)range;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,retain) UIView *inputView;
@property (nonatomic,retain) UIView *inputAccessoryView;

@end
