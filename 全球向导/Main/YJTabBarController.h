//
//  YJTabBarController.h
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNavigationController.h"
#import "ViewController.h"
#import "YJGuideController.h"
#import "YJNewFindController.h"
#import "YJMineController.h"
#import "YJMessageListVC.h"
#import "YJChatVC.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>



@interface YJTabBarController : UITabBarController

@property (nonatomic, strong) YJMessageListVC *messageList;

@property (nonatomic, strong) YJChatVC *chatVC;


- (YJChatVC *)_getCurrentChatView;
- (void)playSoundAndVibration;
- (void)showNotificationWithMessage:(EMMessage *)message;
-(void)setupUnreadMessageCount;
- (BOOL)_needShowNotification:(NSString *)fromChatter;
- (void)_handleReceivedAtMessage:(EMMessage*)aMessage;

- (void)jumpToChatList;

//- (void)didReceiveLocalNotification:(UILocalNotification *)notification;
//
//- (void)didReceiveUserNotification:(UNNotification *)notification;


@end
