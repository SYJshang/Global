//
//  AppDelegate.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "AppDelegate.h"
#import "YJTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import "DNPageView.h"
#import "NSFileManager+DN.h"
#import "DataManager.h"
#import "YJLoginController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>

//#import "WSMovieController.h"


#define USHARE_DEMO_APPKEY @"58cfb59fc8957663c8001a9e"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    //请求获取位置服务
    CLLocationManager *location=[[CLLocationManager alloc]init];
    
    [location requestAlwaysAuthorization];

    
//    [UINavigationBar appearance].translucent = NO;
//    [UINavigationBar appearance].barTintColor= [UIColor colorWithRed:255 / 255.0 green:198 / 255.0 blue:0 / 255.0 alpha:1.0];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[YJTabBarController alloc]init];

    [self.window makeKeyAndVisible];
    
   

    
    

//    XRZLog(@"username:%@, password:%@.",name,password);

    
    
    

//    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *historyVersion =[NSFileManager getAppSettingsForObjectWithKey:@"VersionStr"];
//    if (historyVersion == nil || [historyVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
//        self.first = NO;
//        [NSFileManager setAppSettingsForObject:currentVersion forKey:@"VersionStr"];
//        WSMovieController *wsCtrl = [[WSMovieController alloc]init];
//        wsCtrl.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"]];
//        self.window.rootViewController = wsCtrl;
//        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
//        
////        YJLoginController *login = [[YJLoginController alloc]init];
////        self.window.rootViewController = login;
//        
//        
//    }else{
//        
//        self.window.rootViewController = [[YJTabBarController alloc] init];
//
//    }
//    self.first = YES;
    
    //必须设置在makeKeyAndVisible下才能生效  加载引导页
    [self PageLoadingGuide];
    
    
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];




    // Override point for customization after application launch.
    return YES;
}
    
    
- (void)confitUShareSettings{
        /*
         * 打开图片水印
         */
        //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
        
        /*
         * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         */
        [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    }
    
- (void)configUSharePlatforms
    {
        /* 设置微信的appKey和appSecret */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
        /*
         * 移除相应平台的分享，如微信收藏
         */
        //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
        
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106054634"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
        
        /* 设置新浪的appKey和appSecret */
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];

        
}
    
    

// 加载引导页
- (void)PageLoadingGuide {
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *historyVersion = [NSFileManager getAppSettingsForObjectWithKey:@"VersionStr"];
    if (historyVersion == nil || [historyVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
        [[DNPageView sharePageView] initPageViewToView:self.window dismiss:^{
            self.first = NO;
            [NSFileManager setAppSettingsForObject:currentVersion forKey:@"VersionStr"];
        }];
    }
    self.first = YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    


#pragma mark - 支付接口

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
    return YES;
}

    
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


@end
