//
//  PhoneNormal.h
//  ThouTool
//
//  Created by thou on 6/3/16.
//  Copyright © 2016 thou. All rights reserved.
//

#ifndef PhoneNormal_h
#define PhoneNormal_h

//弱引用
#define WEAKSELF __weak typeof(self) __weakSelf = self;


#define kStatusBarHeight 20
#define kNavigationHeight 44
#define kTabBarNavigationHeight 49

// 状态栏(statusbar)
#define thouStatusBarFrame [[UIApplication sharedApplication] statusBarFrame]

#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height

#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] doubleValue]<8.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) : NO)

#endif /* PhoneNormal_h */
