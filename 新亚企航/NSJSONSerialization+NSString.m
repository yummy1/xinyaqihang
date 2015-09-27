//
//  NSJSONSerialization+NSString.m
//  QiHangDemo
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "NSJSONSerialization+NSString.h"

@implementation NSJSONSerialization (NSString)

+(NSString *)stringWithJSONObjct:(id)obj{
    //转化为二进制数据
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
    //将二进制数据转化为字符串
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return result;
}

@end
