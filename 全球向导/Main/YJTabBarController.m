//
//  YJTabBarController.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJMineNewVC.h"


//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

#define kHaveUnreadAtMessage    @"kHaveAtMessage"
#define kAtYouMessage           1
#define kAtAllMessage           2


#define TextColor [UIColor colorWithRed:255 / 255.0 green:198 / 255.0 blue:0 / 255.0 alpha:1.0]

@interface YJTabBarController ()

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property (nonatomic, strong) YJNavigationController *nav;



@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    //主页
    ViewController *main = [[ViewController alloc]init] ;
//    main.view.backgroundColor = [UIColor redColor];
    [self addChildVc:main Title:YJLocalizedString(@"目的地") withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"home2" withTitleColor:TextColor unselectedImage:@"home" withTitleColor:[UIColor lightGrayColor]];
    //向导
    YJGuideController  *caseVC = [[YJGuideController alloc]init];
//    caseVC.view.backgroundColor = [UIColor grayColor];
    [self addChildVc:caseVC Title:YJLocalizedString(@"向导") withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"guide2" withTitleColor:TextColor unselectedImage:@"guide" withTitleColor:[UIColor lightGrayColor]];
    //新发现
    YJNewFindController *fitVC = [[YJNewFindController alloc]init];
//    fitVC.view.backgroundColor = [UIColor greenColor];
    [self addChildVc:fitVC Title:YJLocalizedString(@"新发现") withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"find2" withTitleColor:TextColor unselectedImage:@"find" withTitleColor:[UIColor lightGrayColor]];
    
    //消息
    self.messageList = [[YJMessageListVC alloc]init];
//    storeVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildVc:self.messageList Title:YJLocalizedString(@"消息") withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"message2" withTitleColor:TextColor unselectedImage:@"message" withTitleColor:[UIColor lightGrayColor]];
    //我的
    YJMineNewVC *MyVC = [[YJMineNewVC alloc]init];
//    MyVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildVc:MyVC Title:YJLocalizedString(@"我的") withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"my2" withTitleColor:TextColor unselectedImage:@"my" withTitleColor:[UIColor lightGrayColor]];

    
    // Do any additional setup after loading the view.
}


- (void)addChildVc:(UIViewController *)childVc
             Title:(NSString *)title
     withTitleSize:(CGFloat)size
       andFoneName:(NSString *)foneName
     selectedImage:(NSString *)selectedImage
    withTitleColor:(UIColor *)selectColor
   unselectedImage:(NSString *)unselectedImage
    withTitleColor:(UIColor *)unselectColor{
    childVc.title = title;
    //设置图片
    childVc.tabBarItem  = [childVc.tabBarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
    self.nav = [[YJNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:self.nav];
}



#pragma mark - 本地推送实现

- (YJChatVC *)_getCurrentChatView
{
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    YJChatVC *chatViewContrller = nil;
    for (id viewController in viewControllers)
    {
        if ([viewController isKindOfClass:[YJChatVC class]])
        {
            chatViewContrller = viewController;
            break;
        }
    }
    return chatViewContrller;
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}


- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    NSString *alertBody = nil;
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        do {
            NSString *title = message.from;
            if (message.chatType == EMChatTypeGroupChat) {
                NSDictionary *ext = message.ext;
                if (ext && ext[kGroupMessageAtList]) {
                    id target = ext[kGroupMessageAtList];
                    if ([target isKindOfClass:[NSString class]]) {
                        if ([kGroupMessageAtAll compare:target options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                    else if ([target isKindOfClass:[NSArray class]]) {
                        NSArray *atTargets = (NSArray*)target;
                        if ([atTargets containsObject:[EMClient sharedClient].currentUsername]) {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                }
                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:message.conversationId]) {
                        title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
                        break;
                    }
                }
            }
            alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        } while (0);
    }
    else{
        alertBody = NSLocalizedString(@"您有一条新消息", @"you have a new message");
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    BOOL playSound = NO;
    if (!self.lastPlaySoundDate || timeInterval >= kDefaultPlaySoundInterval) {
        self.lastPlaySoundDate = [NSDate date];
        playSound = YES;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    
    //发送本地推送
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
//        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger ]
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        if (playSound) {
            content.sound = [UNNotificationSound defaultSound];
        }
        content.body =alertBody;
        content.userInfo = userInfo;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    }
    else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = alertBody;
        notification.alertAction = NSLocalizedString(@"open", @"Open");
        notification.timeZone = [NSTimeZone defaultTimeZone];
        if (playSound) {
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        notification.userInfo = userInfo;
        
        //发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (self.messageList) {
        if (unreadCount > 0) {
            self.messageList.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            self.messageList.tabBarItem.badgeValue = nil;
        }
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}




- (BOOL)_needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EMClient sharedClient].groupManager getGroupsWithoutPushNotification:nil];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    return ret;
}


- (void)_handleReceivedAtMessage:(EMMessage*)aMessage
{
    if (aMessage.chatType != EMChatTypeGroupChat || aMessage.direction != EMMessageDirectionReceive) {
        return;
    }
    
    NSString *loginUser = [EMClient sharedClient].currentUsername;
    NSDictionary *ext = aMessage.ext;
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:aMessage.conversationId type:EMConversationTypeGroupChat createIfNotExist:NO];
    if (loginUser && conversation && ext && [ext objectForKey:kGroupMessageAtList]) {
        id target = [ext objectForKey:kGroupMessageAtList];
        if ([target isKindOfClass:[NSString class]] && [(NSString*)target compare:kGroupMessageAtAll options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSNumber *atAll = conversation.ext[kHaveUnreadAtMessage];
            if ([atAll intValue] != kAtAllMessage) {
                NSMutableDictionary *conversationExt = conversation.ext ? [conversation.ext mutableCopy] : [NSMutableDictionary dictionary];
                [conversationExt removeObjectForKey:kHaveUnreadAtMessage];
                [conversationExt setObject:@kAtAllMessage forKey:kHaveUnreadAtMessage];
                conversation.ext = conversationExt;
            }
        }
        else if ([target isKindOfClass:[NSArray class]]) {
            if ([target containsObject:loginUser]) {
                if (conversation.ext[kHaveUnreadAtMessage] == nil) {
                    NSMutableDictionary *conversationExt = conversation.ext ? [conversation.ext mutableCopy] : [NSMutableDictionary dictionary];
                    [conversationExt setObject:@kAtYouMessage forKey:kHaveUnreadAtMessage];
                    conversation.ext = conversationExt;
                }
            }
        }
    }
}


#pragma mark - public

- (void)jumpToChatList
{
    if ([self.navigationController.topViewController isKindOfClass:[YJChatVC class]]) {
        //        ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
        //        [chatController hideImagePicker];
    }
    else if(self.messageList)
    {
        [self.navigationController popToViewController:self animated:NO];
        self.messageList.tabBarItem.badgeValue = nil;
        [self setSelectedViewController:self.messageList];
    }
}
- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{

    
}

- (void)didReceiveUserNotification:(UNNotification *)notification
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
