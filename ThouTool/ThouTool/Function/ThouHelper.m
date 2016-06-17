//
//  ThouHelper.m
//  ThouTool
//
//  Created by thou on 15/8/11.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import "ThouHelper.h"
#import "PhoneNormal.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation ThouHelper

+(double)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    double timestamp = ceil(time*1000);
    return timestamp;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString*)uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//  十六进制转为颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//  反射对象所有属性
+(NSArray*)propertyKeysWithClass:(Class)classs
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(classs, &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

//  赋值对象所有属性
+(BOOL)reflectDataFromOtherObject:(NSObject*)dataSource WithTarget:(id)target
{
    BOOL ret = NO;
    for (NSString *key in [self propertyKeysWithClass:[target class]]) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [target setValue:[NSString stringWithFormat:@"%@",propertyValue] forKey:key];
            }
        }
    }
    return ret;
}
// 汉子转拼音
+(NSString *)pinyin:(NSString*)sourceString {
    //    if ([sourceString containsString:@"特力"]) {
    //        NSLog(@"%@",sourceString);
    //    }
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    NSArray *ar = [source componentsSeparatedByString:@" "];
    sourceString = @"";
    for (NSString *item in ar) {
        if (item.length>1) {
            sourceString = [sourceString stringByAppendingString:[item substringToIndex:1]];
        }else{
            sourceString = [sourceString stringByAppendingString:item];
        }
        
    }
    return sourceString;
}

// 沙盒目录
+(NSString*)sandBoxPathWithFileName:(NSString*)filename Path:(NSString*)path{
    //获取应用程序沙盒的Library目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",path]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isdirectory = YES;
    if (![filemanager fileExistsAtPath:path isDirectory:&isdirectory]) {
        [filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //NSLog(@"path:%@",path);
    //得到完整的文件名
    NSString *fullFileName=[path stringByAppendingPathComponent:filename];
    
    return fullFileName;
}

//  线条
+(UIView*)drawLineWithSuperView:(UIView*)superView Color:(UIColor*)color Location:(NSInteger)location{
    CGRect frame = superView.frame;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    if (location>0) {
        line.frame = CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5);
    }
    line.backgroundColor = color;
    [superView addSubview:line];
    return line;
}

//  自定义线条
+(UIView*)drawLineWithSuperView:(UIView*)superView Color:(UIColor*)color Frame:(CGRect)frame{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    [superView addSubview:line];
    return line;
}
+(UIView *)showDrawUIviewWithtitle:(NSString *)boby{
    UIView *selfview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    selfview.backgroundColor = [UIColor blackColor];
    selfview.alpha = 0.1;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((UIScreenWidth-200)/2.0, (UIScreenHeight-150-64)/2.0, 200, 150)];
    view.backgroundColor = [UIColor whiteColor];
    //view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.alpha = 0.8;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (view.frame.size.height-40)/2.0, view.frame.size.width, 40)];
    lab.text = boby;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:13];
    UILabel *detialLab = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y+lab.frame.size.height, lab.frame.size.width, 40)];
    detialLab.text = @"关闭";
    detialLab.textAlignment = NSTextAlignmentCenter;
    detialLab.font = [UIFont systemFontOfSize:14];
    [view addSubview:lab];
    [view addSubview:detialLab];
    [selfview addSubview:view];
    return selfview;
    
}
//弹出提示信息
+(void)showSpeacilMessage:(NSString*)body Title:(NSString*)title timeout:(NSInteger)timeout{
    UIAlertView *alertView =  [[UIAlertView alloc] init];
    [alertView setTitle:title];
    [alertView setMessage:body];
    [alertView addButtonWithTitle:@"关闭"];
    
    [alertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:timeout];
    alertView.layer.borderWidth = 10;
    alertView.layer.borderColor = [UIColor grayColor].CGColor;
    alertView.alpha = 0.5;
    [alertView show];
    NSLog(@"%@>>>",alertView.subviews);
}

//  弹出提醒信息
+(void)showMessage:(NSString*)body Title:(NSString*)title timeout:(NSInteger)timeout{
    UIAlertView *alertView =  [[UIAlertView alloc] init];
    [alertView setTitle:title];
    [alertView setMessage:body];
    [alertView addButtonWithTitle:@"关闭"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
    
    [alertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:timeout];
}

+(NSDictionary*)checkNullWithDictionary:(NSDictionary *)dic{
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (NSString *key in dic.allKeys) {
        id value = [dic objectForKey:key];
        
        if (!value || [value isEqual:[NSNull null]]) {
            value = @"";
        }
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        NSString *tempValue = [NSString stringWithFormat:@"%@",value];
        if ([f numberFromString:tempValue]) {
            value = [NSString stringWithFormat:@"%@",value];
        }
        f = nil;
        tempValue = nil;
        [newDic setObject:value forKey:key];
    }
    return newDic;
}

//  返回真实沙盒地址
+(NSString*)realPathWithFileName:(NSString*)filename Path:(NSString*)path{
    //获取应用程序沙盒的目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",path]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isdirectory = YES;
    if (![filemanager fileExistsAtPath:path isDirectory:&isdirectory]) {
        [filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //NSLog(@"path:%@",path);
    //得到完整的文件名
    NSString *fullFileName=[path stringByAppendingPathComponent:filename];
    
    return fullFileName;
}

+(NSArray*)searchStatus:(NSString*)keywords{
    return nil;
    //*代表通配符,Like也接受[cd].
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",keywords];
    NSArray *stocks = @[];//[ThouAppDelegate shareApp].status;
    NSArray *rs = [stocks filteredArrayUsingPredicate:predicate];
    if (rs.count<=0) {
        rs = @[keywords];
    }
    predicate = nil;
    stocks = nil;
    return rs;
}

+(void)sleepSeconds:(float)senconds finishBlock:(void(^)())block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //sleep((int)senconds);
        [NSThread sleepForTimeInterval:senconds];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}

+(NSDictionary*)urlParams:(NSString*)paths{
    if ([paths rangeOfString:@"?"].location==NSNotFound) {
        return nil;
    }
    paths = [paths substringFromIndex:[paths rangeOfString:@"?"].location+1];
    NSArray *d = [paths componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (NSString *item in d) {
        NSArray *keyvalues = [item componentsSeparatedByString:@"="];
        [dic setObject:[keyvalues lastObject] forKey:[keyvalues firstObject]];
        keyvalues = nil;
    }
    
    return dic;
}
@end
