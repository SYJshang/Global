//
//  NSFileManager+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSFileManager+DN.h"

#define APP_NAME @"App"
@implementation NSFileManager (DN)

+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName {
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)setingsFilePath:(NSString *)setName {
    return [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@-Settings.plist",setName]];
}

+ (id)getAppSettingsForObjectWithKey:(NSString *)objKey {
    return [self getSettings:APP_NAME objectForKey:objKey];
}

+ (BOOL)setAppSettingsForObject:(id)value forKey:(NSString *)objKey {
    return [self setSettings:APP_NAME object:value forKey:objKey];
}

+ (id)getSettings:(NSString *)settings objectForKey:(NSString *)objKey {
    NSString *path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    NSDictionary *loadedPlist = [NSDictionary dictionaryWithContentsOfFile:path];
    return [loadedPlist objectForKey:objKey];
}

+ (BOOL)setSettings:(NSString *)settings object:(id)value forKey:(NSString *)objKey {
    NSString *path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    NSMutableDictionary *loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!loadedPlist) {
        loadedPlist = [NSMutableDictionary dictionary];
    }
    [loadedPlist setObject:value forKey:objKey];
    return [loadedPlist writeToFile:path atomically:YES];
}

@end

