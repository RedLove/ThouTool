//
//  ThouThemeManager.m
//  ThouTool
//
//  Created by thou on 15/8/9.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import "ThouThemeManager.h"

#import "ViewNormal.h"
#import "PhoneNormal.h"
#import "ThouHelper.h"

NSString * const ThemeDidChangeNotification = @"me.ilvu.theme.change";
@implementation ThouThemeManager

@synthesize theme = _theme;

+ (ThouThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static ThouThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[ThouThemeManager alloc] init]; } );
    return instance;
}

- (void)setTheme:(NSString *)theme
{
    if (_theme) {
        _theme = nil;
    }
    _theme = [theme copy];
    
    // post notification to notify the observers that the theme has changed
    ThemeStatus status = ThemeStatusDidChange;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ThemeDidChangeNotification
     object:[NSNumber numberWithInt:status]];
    
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:@"setting.theme"];
    
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSString *directory = [NSString stringWithFormat:@"%@/%@", kThemeName,[self theme]];
    if ([imageName rangeOfString:@"/"].location>0 && [imageName rangeOfString:@"/"].location<NSIntegerMax) {
        NSArray *dirs = [imageName componentsSeparatedByString:@"/"];
        NSString *ndir = [imageName stringByReplacingOccurrencesOfString:[dirs lastObject] withString:@""];
        directory = [directory stringByAppendingString:[NSString stringWithFormat:@"/%@",ndir]];
        imageName = [dirs lastObject];
    }
    NSString *imageName_568 = [imageName stringByAppendingString:@"-568@2x"];
    NSString *imageName_3x = [imageName stringByAppendingString:@"@3x"];
    imageName = [imageName stringByAppendingString:@"@2x"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName
                                                          ofType:@"png"
                                                     inDirectory:directory];
    NSString *imagePath_568 = [[NSBundle mainBundle] pathForResource:imageName_568
                                                              ofType:@"png"
                                                         inDirectory:directory];
    NSString *imagePath_3x = [[NSBundle mainBundle] pathForResource:imageName_3x
                                                              ofType:@"png"
                                                         inDirectory:directory];
    NSFileManager *f = [[NSFileManager defaultManager] init];
    if (!iPhone4 && [f fileExistsAtPath:imagePath_568]) {
        imagePath = imagePath_568;
    }
    if ((iPhone6Plus) && [f fileExistsAtPath:imagePath_3x]) {
        imagePath = imagePath_3x;
    }
    f = nil;
    
    
    //NSLog(@"directory=%@",directory);
    //NSLog(@"imageName=%@",imageName);
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    return img;
}

- (NSDictionary *)jsonWithFileName:(NSString *)filename
{
    NSString *directory = [NSString stringWithFormat:@"%@/json", kThemeName];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename ofType:@".json" inDirectory:directory];
    
    NSString *jsonstr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *jsonData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        return @{};
    }
    NSDictionary *data = [json objectForKey:@"datas"];
    NSDictionary *list = (NSDictionary*)[data objectForKey:@"list"] ;
    
    return list;
}

- (NSString *)jsWithFileName:(NSString *)filename
{
    NSString *directory = [NSString stringWithFormat:@"%@/js", kThemeName];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename
                                                         ofType:@".js"
                                                    inDirectory:directory];
    
    NSString *jsonstr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    return jsonstr;
}


- (void)jsonSaveFileName:(NSString *)filename Content:(NSDictionary*)dic
{
    //NSDictionary *list = [NSDictionary dictionaryWithObject:dic forKey:@"list"] ;
    //NSDictionary *data = [NSDictionary dictionaryWithObject:list forKey:@"datas"] ;
    //NSString *jsonstr = [data JSONRepresentation];
    // 写入文件
    //[CommonOperation createCacheWithFileName:filename Path:@"json" Content:dic];
    
}


#pragma mark 获取颜色配置
-(UIColor*)colorWithName:(NSString*)keyname{
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"bundlepath:%@",bundlePath);
    
    NSString *filename = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/Root.plist",kThemeName,[self theme]]];
    //读文件
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSString *value = [plist objectForKey:keyname];
    plist = nil;
    filename = nil;
    bundlePath = nil;
    if (value) {
        
        UIColor *c = [fn colorWithHexString:value];
        value = nil;
        return c;
    }
    return UIColorFromRGB(0xFFFFFF);
}

- (NSString *)theme
{
    
    if ( _theme == nil )
    {
        NSString *_t = [[NSUserDefaults standardUserDefaults] objectForKey:@"setting.theme"];
        if (!_t) {
            _t = @"default";
        }
        return _t;
    }
    return _theme;
}


@end
