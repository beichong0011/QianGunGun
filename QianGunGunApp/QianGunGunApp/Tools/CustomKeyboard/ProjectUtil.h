//
//  ProjectUtil.h
//  CSDirectBank
//
//  Created by Csr-Mac on 14-6-5.
//  Copyright (c) 2014年 丁丁. All rights reserved.
//
#import <Foundation/Foundation.h>
@class PCLoginSession;

@interface ProjectUtil : NSObject

+ (NSString *)maskString:(NSString *)sourceStr;
+(NSString *)maskStringLast:(NSString *)sourceStr;
@end
