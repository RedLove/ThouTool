//
//  UITableViewCell+Background.m
//  ThouTool
//
//  Created by thou on 16/5/25.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "UITableViewCell+Background.h"

@implementation UITableViewCell (Background)

- (void)backgroundGradient:(NSIndexPath *)indexPath
{
    [self backgroundGradient:indexPath withOddColor:kCellOddColor andEvenColor:kCellEvenColor];
}

- (void)backgroundGradient:(NSIndexPath *)indexPath withOddColor:(UIColor *)oddColor andEvenColor:(UIColor *)evenColor
{
    if (indexPath.row % 2 == 0) {
        self.contentView.backgroundColor = oddColor;
    }else{
        self.contentView.backgroundColor = evenColor;
    }
}

@end
