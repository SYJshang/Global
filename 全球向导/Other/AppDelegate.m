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
#import "YJChatVC.h"
#import "YJMessageListVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UserNotifications/UserNotifications.h>
#import "KeychainIDFA.h"
#import "YJReveingDetailVC.h"

//#import "WSMovieController.h"

static NSString *appLanguage = @"appLanguage";

#define USHARE_DEMO_APPKEY @"58cfb59fc8957663c8001a9e"


@interface AppDelegate ()<EMChatManagerDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>

@property (nonatomic, strong)CLLocationManager *location;

@property (nonatomic, strong) YJTabBarController *tabBarVC;



@end

@implementation AppDelegate



- (void)didReceiveMessages:(NSArray *)aMessages
{
    
    BOOL isRefreshCons = YES;

    for (EMMessage *message in aMessages) {
        
        EaseMessageModel *model = [[EaseMessageModel alloc] initWithMessage:message];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        [userDefault setObject:model.message.ext forKey:model.message.from];
        [userDefault synchronize];
        
        BOOL needShowNotification = (message.chatType != EMChatTypeChat) ? [self.tabBarVC _needShowNotification:message.conversationId] : YES;
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
            switch (state) {
                case UIApplicationStateActive:
                    [self.tabBarVC playSoundAndVibration];
                    break;
                case UIApplicationStateInactive:
                    [self.tabBarVC playSoundAndVibration];
                    break;
                case UIApplicationStateBackground:
                    [self.tabBarVC showNotificationWithMessage:message];
                    break;
                default:
                    break;
            }
#endif
        }
        
        if (self.tabBarVC.chatVC == nil) {
            self.tabBarVC.chatVC = [self.tabBarVC _getCurrentChatView];
        }
        BOOL isChatting = NO;
        if (self.tabBarVC.chatVC) {
            isChatting = [message.conversationId isEqualToString:self.tabBarVC.chatVC.conversation.conversationId];
        }
        if (self.tabBarVC.chatVC == nil || !isChatting || state == UIApplicationStateBackground) {
            [self.tabBarVC _handleReceivedAtMessage:message];
            
            if (self.tabBarVC.messageList) {
                [self.tabBarVC.messageList tableViewDidTriggerHeaderRefresh];
            }
            
            if (self) {
                [self.tabBarVC setupUnreadMessageCount];
            }
            return;
        }
        
        if (isChatting) {
            isRefreshCons = NO;
        }

    }
    
    if (isRefreshCons) {
        if (self.tabBarVC.messageList) {
            [self.tabBarVC.messageList refresh];
        }
        
        if (self.tabBarVC) {
            [self.tabBarVC setupUnreadMessageCount];
        }
    }

}


- (void)dealloc{
    
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firsts"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firsts"];
        
        NSString *deviceID = [KeychainIDFA IDFA];
        deviceID = [deviceID stringByReplacingOccurrencesOfString:@"-"withString:@"_"];
        [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:@"deviceID"];
    }

    
    
    //避免启动页图片一闪而过的现象
    [NSThread sleepForTimeInterval:3.0];
    
    // Override point for customization after application launch.
    //请求获取位置服务
    self.location = [[CLLocationManager alloc]init];
    
    [self.location requestAlwaysAuthorization];
    
    

    
//    [UINavigationBar appearance].translucent = NO;
//    [UINavigationBar appearance].barTintColor= [UIColor colorWithRed:255 / 255.0 green:198 / 255.0 blue:0 / 255.0 alpha:1.0];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabBarVC = [[YJTabBarController alloc]init];
    self.window.rootViewController = self.tabBarVC;

    [self.window makeKeyAndVisible];
    
    //必须设置在makeKeyAndVisible下才能生效  加载引导页
    [self PageLoadingGuide];
    
    //设置语言
    [self setLangueage];
    
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    //设置友盟统计
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    
    //上线时候要把这个隐藏
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"58cfb59fc8957663c8001a9e";
    UMConfigInstance.channelId = @"App Store";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
    
    NSString *apnsCertName = nil;

#if DEBUG
    apnsCertName = @"Dev_Push";
#else
    apnsCertName = @"Nor_Push";
#endif

    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1159170320115280#globalguide"];
    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    application.applicationIconBadgeNumber = 0;
    
    //iOS8以上 注册APNS
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError *error) {
            if (granted) {
#if !TARGET_IPHONE_SIMULATOR
                [application registerForRemoteNotifications];
#endif
            }
        }];
        
        
    }
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    
    //添加监听在线推送消息
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient] setApnsNickname:@"全球向导"];
    
    
    //极光
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert)categories:nil];

        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"baea3b57c9e2c6e5c81e41ab"
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
    

    
//    
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
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa373ab30fe698506" appSecret:@"a2c5c231bd2943d880427e4110057ae1" redirectURL:@"http://mobile.umeng.com/social"];
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
            YJLoginController *vc = [[YJLoginController alloc]init];
            self.window.rootViewController = vc;
        }];
    }
    self.first = YES;
}



#pragma mark - 设置语言
- (void)setLangueage {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:appLanguage] == nil || [[NSUserDefaults standardUserDefaults] objectForKey:@"state"] == nil) {
        NSArray  *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"zh-Hans"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
        } else if ([language hasPrefix:@"zh-TW"] || [language hasPrefix:@"zh-HK"] || [language hasPrefix:@"zh-Hant"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:appLanguage];
        } else if ([language hasPrefix:@"en"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:appLanguage];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
        }
    }
}


#pragma mark - 注册推送，把deviceToken传递给sdk

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
    [JPUSHService setTags:nil alias:deviceId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        

    }];
    
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];

    
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];

    if (self.tabBarVC) {
        [self.tabBarVC jumpToChatList];
    }
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    
    
}




- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didReceiveRemoteNotification:userInfo];
}



//监听环信在线推送消息
- (void)messagesDidReceive:(NSArray *)aMessages{
    
#if !TARGET_IPHONE_SIMULATOR
//    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        
    }
#endif
}




- (void)applicationWillResignActive:(UIApplication *)application {
  
}



// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];

    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    completionHandler();
    
    
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
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
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
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
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


#pragma mark- JPUSHRegisterDelegate


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    
    NSDictionary *userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            [self popAlert:userInfo];
            
        }
        
        else{
            //跳转到指定页面
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
            //这里也可以发送个通知,跳转到指定页面
            // [self readNotificationVcWithUserInfo:userInfo];
            
        }

        
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Inactive" forKey:@"applicationState"];
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            [self popAlert:userInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationState" object:@"0"];
            
        }
        
        else{
            
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
            //这里也可以发送个通知,跳转到指定页面
            // [self readNotificationVcWithUserInfo:userInfo];
        }
        
    }
    completionHandler();  // 系统要求执行这个方法
    
}

//2. 如果App状态为正在前台或者点击通知栏的通知消息，苹果的回调函数将被调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//    // 取得 APNs 标准信息内容
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
   
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (application.applicationState == UIApplicationStateActive) {
        //程序运行时收到通知，先弹出消息框
//        [self popAlert:userInfo];
        
        
    }
    
    else{
        //程序已经关闭或者在后台运行
        [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        //这里也可以发送个通知,跳转到指定页面
        // [self readNotificationVcWithUserInfo:userInfo];
        
    }
    
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [application setApplicationIconBadgeNumber:0];//小红点清0操作
}


#pragma mark -- 程序运行时收到通知
-(void)popAlert:(NSDictionary *)pushMessageDic{
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"提示" message:[[pushMessageDic objectForKey:@"aps"]objectForKey:@"alert"]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction =
    [UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pushToViewControllerWhenClickPushMessageWith:pushMessageDic];
    }];
    
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)pushToViewControllerWhenClickPushMessageWith:(NSDictionary*)msgDic{
    
    
//    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    
    if ([[msgDic objectForKey:@"type"] integerValue]==1){
        //详情，这是从跳转到第一个tabbarItem跳转过去的，所以我们可以先让tabController.selectedIndex =0;然后找到VC的nav。
        
        self.tabBarVC.selectedIndex =0;
        YJReveingDetailVC  *VC = [[YJReveingDetailVC alloc]init];
        VC.orderId = msgDic[@"orderId"];
        [VC setHidesBottomBarWhenPushed:YES];
        YJNavigationController *nav=(YJNavigationController *)self.tabBarVC.viewControllers[0];
        UIViewController *vc= (UIViewController*)nav.viewControllers.firstObject;
        
        [vc.navigationController pushViewController:VC animated:NO];
        
    }else {
        
    }

}


@end
