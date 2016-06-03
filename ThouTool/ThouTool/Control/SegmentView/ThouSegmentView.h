//
//  ThouSegmentView.h
//  ThouTool
//
//  Created by thou on 16/5/5.
//  Copyright © 2016年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>

//推荐高度
#define kMarketSegmentHeight 31

typedef NS_ENUM(NSUInteger,ThouSegmentViewStyle){
    ThouSegmentViewStyleDefault,
    ThouSegmentViewStyleHorizonalLine
};

@interface ThouSegmentView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles andStyle:(ThouSegmentViewStyle)style;

/**
 *  紧跟初始化后调用用来设置内部滑动视图的大小。
 *
 *  @param frame 内部滑动区域大小
 */
- (void)setSubViewControllerSize:(CGRect)frame;
- (void)setSubViewControllers:(NSArray<UIViewController *> *)subViewControllers;


@end
