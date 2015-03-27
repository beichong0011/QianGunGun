//
//  ProjectUtil.m
//  CSDirectBank
//
//  Created by Csr-Mac on 14-6-5.
//  Copyright (c) 2014年 丁丁. All rights reserved.
//
#define BlackPoint @"●"
#import "ProjectUtil.h"
@implementation ProjectUtil
#pragma mark- Keyboard methods
+ (NSString *)maskString:(NSString *)sourceStr {
    NSString *tempString = @"";
    for (int i =0; i<sourceStr.length; i++) {
        tempString =[tempString stringByAppendingString:BlackPoint];
    }
    return tempString;
}

+(NSString *)maskStringLast:(NSString *)sourceStr
{
    NSString *tempString = @"";
    NSInteger length = sourceStr.length - 1;
    for (int i =0; i<length; i++) {
        tempString =[tempString stringByAppendingString:BlackPoint];
    }
    if(sourceStr.length > 0)
    {
        NSString *strLastChar =[sourceStr substringWithRange:NSMakeRange(length, 1)];
        tempString = [tempString stringByAppendingString:strLastChar];
    }
    return tempString;
}
@end