//
//  ImportantDataManager.h
//  Keychain_Demo
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *password;

+ (DataManager *)shareManager;

- (void)saveUsername:(NSString *)username andPassword:(NSString *)password;
/**
 * 返回值是一个字典
 * 通过属性username作为key取得的值是『用户名』
 * 通过属性password作为key取得的值是『密码』
 */
- (NSDictionary *)loadUsernameAndPassword;
- (void)deleteUsernameAndPassword;

@end
