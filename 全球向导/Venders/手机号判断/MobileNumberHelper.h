//
//  MobileNumberHelper.h
//  PhoneCheckDemo
//
//  Created by Arlexovincy on 14-3-2.
//  Copyright (c) 2014年 Arlexovincy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileNumberHelper : NSObject

/**
 *  判断是否为手机号码格式
 *
 *  @param mobileNumString 需要被判断的字符串
 *
 *  @return 是否为手机号码
 */
+ (BOOL)isMobileNumber:(NSString*)mobileNumString;

//密码判断
+ (BOOL)isValidPassword:(NSString *)passWordString;
//正则表达式封装
//+ (BOOL)isValidateByRegex:(NSString *)regex;


@end
