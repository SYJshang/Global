//
//  NSFileManager+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (DN)

/**
 *  获取App设置文件中key对应得内容
 *
 *  @param objKey key
 *
 *  @return 内容
 */
+ (id)getAppSettingsForObjectWithKey:(NSString *)objKey;

/**
 *  设置APP设置文件中填入key value
 *
 *  @param value  value
 *  @param objKey key
 *
 *  @return 是否写入成功
 */
+ (BOOL)setAppSettingsForObject:(id)value forKey:(NSString *)objKey;


@end
