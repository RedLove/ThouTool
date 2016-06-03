//
//  ThouHelper.h
//  ThouTool
//
//  Created by thou on 15/8/11.
//  Copyright (c) 2015年 thou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define fn ThouHelper

@interface ThouHelper : NSObject
/**
 *  获取时间戳
 *
 *  @return 精确到秒
 */
+(double)getTimestamp;

/**
 *  MD5加密
 *
 *  @param str 待加密字符串
 *
 *  @return 加密后字符串
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  颜色码转颜色
 *
 *  @param stringToConvert 十六进制颜色值
 *
 *  @return 颜色
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

/**
 *  反射对象所有属性
 *
 *  @param classs 对象
 *
 *  @return 属性数组
 */
+(NSArray*)propertyKeysWithClass:(Class)classs;

/**
 *  赋值对象所有属性
 *
 *  @param dataSource 值字典
 *  @param target     对象
 *
 *  @return 是否成功
 */
+(BOOL)reflectDataFromOtherObject:(NSObject*)dataSource WithTarget:(id)target;

/**
 *  汉子转拼音
 *
 *  @param sourceString 源字符串
 *
 *  @return 返回拼音字符串
 */
+(NSString *)pinyin:(NSString*)sourceString;

/**
 *  沙盒路径
 *
 *  @param filename 文件名称
 *  @param path     路径名称
 *
 *  @return 返回真实沙盒路径地址
 */
+(NSString*)sandBoxPathWithFileName:(NSString*)filename Path:(NSString*)path;

/**
 *  画线条
 *
 *  @param superView 父视图
 *  @param color     线条延伸
 *  @param location  位置 0=顶部 1=底部
 *
 *  @return 线条
 */
+(UIView*)drawLineWithSuperView:(UIView*)superView Color:(UIColor*)color Location:(NSInteger)location;

/**
 *  自定义线条
 *
 *  @param superView 父视图
 *  @param color     延伸
 *  @param frame     位置
 *
 *  @return 线条
 */
+(UIView *)drawLineWithSuperView:(UIView*)superView Color:(UIColor*)color Frame:(CGRect)frame;

/**
 *  提示框
 *
 *  @param body    内容
 *  @param title   标题
 *  @param timeout 超时关闭
 */
+(void)showMessage:(NSString*)body Title:(NSString*)title timeout:(NSInteger)timeout;
+(void)showSpeacilMessage:(NSString*)body Title:(NSString*)title timeout:(NSInteger)timeout;
+(UIView *)showDrawUIviewWithtitle:(NSString *)boby;
/**
 *  过滤接口数据Null值
 *
 *  @param dic 接口数据
 *
 *  @return 新数据
 */
+(NSDictionary*)checkNullWithDictionary:(NSDictionary*)dic;

/**
 *  返回真实沙盒地址
 *
 *  @param filename 文件名
 *  @param path     文件夹
 *
 *  @return 沙盒地址 document/path/filename
 */
+(NSString*)realPathWithFileName:(NSString*)filename Path:(NSString*)path;

/**
 *  搜索本地状态
 *
 *  @param keywords 关键词
 *
 *  @return 搜索结果
 */
+(NSArray*)searchStatus:(NSString*)keywords;

/**
 *  真实股票代码
 *
 *  @param keyword 关键词
 *
 *  @return 股票代码
 */
+(NSString*)stockCodeWithKeyword:(NSString*)keyword;
/**
 *  延迟执行
 *
 *  @param senconds 延迟秒数
 *  @param block    执行快
 */
+(void)sleepSeconds:(float)senconds finishBlock:(void(^)())block;

/**
 *  获取参数
 *
 *  @param paths url地址带参数
 *
 *  @return 参数字典
 */
+(NSDictionary*)urlParams:(NSString*)paths;
@end
