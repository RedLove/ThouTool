//
//  UIView+Z_Order.h
//  ThouTool
//
//  Created by thou on 16/5/17.
//  Copyright © 2016年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Z_Order)

-(NSUInteger)getSubviewIndex;
-(void)bringToFront;
-(void)sendToBack;
-(void)bringOneLevelUp;
-(void)sendOneLevelDown;
-(BOOL)isInFront;
-(BOOL)isAtBack;
-(void)swapDepthsWithView:(UIView*)swapView;

@end
