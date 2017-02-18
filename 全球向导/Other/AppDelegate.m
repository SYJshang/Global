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
//#import "WSMovieController.h"

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



    // Override point for customization after application launch.
    return YES;
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


@end
