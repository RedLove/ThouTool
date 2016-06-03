//
//  NSDictionary+Log.m
//  ThouTool
//
//  Created by thou on 15/9/25.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    // 遍历数组中的所有内容，将内容拼接成一个新的字符串返回
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendString:@"{\n"];
    
    [[self allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // 在拼接字符串时，会调用obj的description方法
//        NSString *value = [[self valueForKey:obj] description];
        [strM appendFormat:@"\t%@ = %@,\n", obj,[self valueForKey:obj]];
    }];
    

    [strM appendString:@"}"];
    
    return strM;
}

@end
