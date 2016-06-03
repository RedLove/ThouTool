//
//  NSString+URL.h
//  ThouTool
//
//  Created by thou on 16/3/6.
//  Copyright © 2016年 thou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)URLEncodedString;
- (NSString *)stringByDecodingURLFormat;

- (NSDictionary *)paramsToDict;

@end
