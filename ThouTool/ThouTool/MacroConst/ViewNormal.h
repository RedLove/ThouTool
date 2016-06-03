//
//  ViewNormal.h
//  thouTool
//
//  Created by thou on 6/3/16.
//  Copyright © 2016 thou. All rights reserved.
//

#ifndef ViewNormal_h
#define ViewNormal_h

#import "ThouThemeManager.h"

//字体
// HelveticaNeue，HelveticaNeue-Bold
#define kFontSize 14.0
#define kFontName @"HelveticaNeue"
#define kFontBoldName @"HelveticaNeue"
//#define kFontNumberName @"DINAlternate-Bold"
#define kFontNumberName @"arial"
#define kFontNumberBoldName @"DINAlternate-Bold"
#define kFont(fontSize) [UIFont fontWithName:kFontName size:fontSize]
#define kFontBold(fontSize) [UIFont fontWithName:kFontBoldName size:fontSize]
#define kFontNumber(fontSize) [UIFont fontWithName:kFontNumberName size:fontSize]
#define kFontNumberBold(fontSize) [UIFont fontWithName:kFontNumberBoldName size:fontSize]
#define kDefaultFont kFont(kFontSize)

//-----------------------字体颜色----------------------------
#pragma mark - 字体颜色
#define kBgcolor thouRGB(238,238,238)
#define k1Titlecolor thouRGB(74,74,74)
#define k2Titlecolor thouRGB(104,104,104)
#define k3Titlecolor thouRGB(134,134,134)
#define k4Titlecolor thouRGB(166,166,166)
#define k5Titlecolor thouRGB(234,79,77)
#define k6Titlecolor thouRGB(51,204,102)
#define k7Titlecolor thouRGB(0,153,255)
#define k8Titlecolor thouRGB(108,124,161)
#define k9Titlecolor thouRGB(193,193,193)
#define kd1bgcolor thouRGB(238,238,238)
#define kd2linecolor thouRGB(220,220,220)

//-----------------------字体大小----------------------------
#pragma mark - 字体大小
#define kATitleSize 11
#define kBTitleSize 12
#define kCTitleSize 14
#define kDTitleSize 15
#define kETitleSize 16
#define kFTitleSize 18
#define kGTitleSize 25
#define kHTitleSize 35
#define kITitleSize 40

//----------------------颜色类---------------------------
// 获取RGB颜色
#define thouRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define thouRGB(r,g,b) thouRGBA(r,g,b,1.0f)

#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

// 色彩
#define thouColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0
#define thouRandom255Color arc4random()%255
#define thouRandomColor thouColor(thouRandom255Color,thouRandom255Color,thouRandom255Color)

//-----------------------常用颜色----------------------------
#define thouClearColor [UIColor clearColor]
#define thouRedColor UIColorFromRGB(0xde3031)
#define thouGreenColor UIColorFromRGB(0x18c062)
#define thouGreyColor UIColorFromRGB(0xb0b0b0)
#define thouBlueColor UIColorFromRGB(0x0592ff)
#define thouYellowColor UIColorFromRGB(0xff8448)
#define thouLowGreenColor UIColorFromRGB(0x61da9d)
#define thouZeroColor UIColorFromRGB(0x000000)
#define thouBlackColor ThemeColor(@"Font_Black_Color")
#define thouBgGreyColor ThemeColor(@"Body_Grey_Color")
#define thouBottomLineColor ThemeColor(@"UITableViewCell_BottomLine_Color")
#define thouNoPhotoBgColor ThemeColor(@"Body_Grey_Color")
#define thouNavColor ThemeColor(@"Navigation_Bg_Color")

/*
 宏调用定义视图统一圆角
 */
#define thouViewCornerDefaultRadius(view) view.layer.cornerRadius = view.frame.size.width * 0.02; \
view.layer.masksToBounds = YES;
#define thouViewCornerRadius(view,radius) view.layer.cornerRadius = view.frame.size.width * radius; \
view.layer.masksToBounds = YES;

#endif /* ViewNormal_h */
