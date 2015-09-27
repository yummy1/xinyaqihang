//
//  NSJSONSerialization+NSString.h
//  QiHangDemo
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (NSString)

/**
 *  将json Object 转化为string
 */

+(NSString *)stringWithJSONObjct:(id)obj;

@end
