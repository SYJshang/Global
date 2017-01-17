//
//  ImportantDataManager.m
//  Keychain_Demo
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DataManager.h"
#import "SZYKeychain.h"

static DataManager *singleInstance = nil;

static NSString *const kSZYKeyChain_USERNAME_PASSWORD = @"cc.suzhenyu.usernamepassword";
static NSString *const kSZYKeyChain_USERNAME = @"cc.suzhenyu.username";
static NSString *const kSZYKeyChain_PASSWORD = @"cc.suzhenyu.password";

@implementation DataManager

+ (DataManager *)shareManager {
    @synchronized(self) {
        if (!singleInstance) {
            singleInstance = [[self alloc] init];
        }
        return singleInstance;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _username = kSZYKeyChain_USERNAME;
        _password = kSZYKeyChain_PASSWORD;
    }
    return self;
}

- (void)saveUsername:(NSString *)username andPassword:(NSString *)password {
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:username forKey:kSZYKeyChain_USERNAME];
    [dataDict setObject:password forKey:kSZYKeyChain_PASSWORD];
    [SZYKeychain saveKeychain:kSZYKeyChain_USERNAME_PASSWORD withData:dataDict];
}

- (NSDictionary *)loadUsernameAndPassword {
    
    return [SZYKeychain loadKeychain:kSZYKeyChain_USERNAME_PASSWORD];
}
- (void)deleteUsernameAndPassword {
    [SZYKeychain deleteKeyChain:kSZYKeyChain_USERNAME_PASSWORD];
}


@end
