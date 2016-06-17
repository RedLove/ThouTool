//
//  NetWorkNormal.h
//  ThouTool
//
//  Created by thou on 6/3/16.
//  Copyright © 2016 thou. All rights reserved.
//

#ifndef NetWorkNormal_h
#define NetWorkNormal_h

// 接口地址
#ifndef DEBUG

#define kBaseURL @"http://localhost:8080/stockapi"

#else

#define kBaseURL @"https://www.google.co.jp"

#endif

#define kURL(...) [kBaseURL stringByAppendingFormat:__VA_ARGS__]

#endif /* NetWorkNormal_h */
