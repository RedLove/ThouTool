//
//  ThouHorizonalLiveView.m
//  ThouTool
//
//  Created by thou on 16/5/17.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "ThouHorizonalLiveView.h"

@implementation ThouHorizonalLiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    
    CGFloat lineHeight = 1;
    CGFloat lineWidth = 70;
    
    CGContextSetLineWidth(ctx, lineHeight);
    [[UIColor redColor] set];
    
    CGContextMoveToPoint(ctx, (self.bounds.size.width - lineWidth) / 2 , self.bounds.size.height - lineHeight);
    
    CGContextAddLineToPoint(ctx, (self.bounds.size.width + lineWidth) / 2 , self.bounds.size.height - lineHeight);
    
    CGContextStrokePath(ctx);
}

@end
