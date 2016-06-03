//
//  NSString+URL.m
//  ThouTool
//
//  Created by thou on 16/3/6.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

- (NSDictionary *)paramsToDict
{
    //获取问号的位置，问号后是参数列表
    NSRange range = [self rangeOfString:@"?"];
    NSLog(@"参数列表开始的位置：%d", (int)range.location);
    
    //获取参数列表
    NSString *propertys = [self substringFromIndex:(int)(range.location+1)];
    NSLog(@"截取的参数列表：%@", propertys);
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    NSLog(@"把每个参数列表进行拆分，返回为数组：n%@", subArray);
    
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
    
    for (int j = 0 ; j < subArray.count; j++){
        //在通过=拆分键和值
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
        NSLog(@"再把每个参数通过=号进行拆分：n%@", dicArray);
        //给字典加入元素
        [tempDic setObject:[dicArray[1] stringByDecodingURLFormat] forKey:dicArray[0]];
    }
    NSLog(@"打印参数列表生成的字典：n%@", tempDic);
    
    return tempDic;
}

@end
