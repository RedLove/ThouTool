//
//  ThouStockKeyboard.h
//  FMMarket
//
//  Created by 石大千 on 16/3/7.
//  Copyright © 2016年 sdcf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITextField+ExtendRange.h"
#import "UITextView+ExtendRange.h"

typedef NS_ENUM(NSInteger,ThouStockKeyboardType){
    ThouStockKeyboardTypeNumber = 100,
    ThouStockKeyboardTypeCharacter
};

@protocol ThouStockKeyboardDelegate <NSObject>

@required

- (void)keyboardWillResignFirstResponse:(UIView *)keyboard;

@optional

- (void)keyboard:(UIView *)keyboard changeType:(ThouStockKeyboardType)type;

- (void)keyboardBackspace:(UIView *)keyboard;

- (void)keyboard:(UIView *)keyboard input:(NSString *)character;

@end

@interface ThouStockKeyboard : UIView

@property (nonatomic,weak) id<ThouStockKeyboardDelegate> delegate;

@property (nonatomic,weak) id<UITextInputExtendRange> inputView;

- (instancetype)initWithInputView:(id<UITextInputExtendRange>)view;

@end
