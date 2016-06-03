//
//  ThouUnderLineView.m
//  ThouTool
//
//  Created by thou on 16/5/5.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "ThouUnderLineView.h"
#import "ViewNormal.h"

@implementation ThouUnderLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    
    CGFloat pad = 4;
    CGFloat lineHeight = 1;
    CGFloat pointX = 0;
    CGFloat pointY = self.bounds.size.height - lineHeight;
    
    [thouRedColor set];
    CGContextSetLineWidth(ctx, lineHeight);
    
    CGContextMoveToPoint(ctx,pointX,pointY);
    
    pointX = self.bounds.size.width * 0.5 - pad;
    
    CGContextAddLineToPoint(ctx,pointX,pointY);
    
    pointX += pad * 0.5 ;
    pointY = self.bounds.size.height - pad - lineHeight;
    
    CGContextAddLineToPoint(ctx, pointX, pointY);
    
    pointX += pad * 0.5 ;
    pointY = self.bounds.size.height - lineHeight;
    CGContextAddLineToPoint(ctx, pointX, pointY);
    
    pointX = self.bounds.size.width;
    CGContextAddLineToPoint(ctx, pointX, pointY);
    
    CGContextStrokePath(ctx);
}

@end
