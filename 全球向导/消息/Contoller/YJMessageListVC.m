
//
//  YJMessageListVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/31.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMessageListVC.h"
#import "YJChatVC.h"
#import "YJChatCell.h"
#import "NoNetwork.h"
#import "YJLoginFirstController.h"

@interface YJMessageListVC ()<YJMessageVCDelegate, YJMessageVCDataSource>

@property (nonatomic, strong) UIView *networkStateView;

@property (nonatomic, strong) NSIndexPath *index;

@property (nonatomic, strong) NoNetwork *noNetWork;

@end

@implementation YJMessageListVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code = [userDefault objectForKey:@"code"];
    if ([code isEqualToString:@"1"]) {
        [self networkStateView];
        
        [self tableViewDidTriggerHeaderRefresh];
        
        if (self.dataArray.count == 0) {
            [self noDatas];
        }else{
            self.tableView.hidden = NO;
            self.noNetWork.hidden = YES;
        }
        XXLog(@"%@",self.dataArray);
        [self removeEmptyConversationsFromDB];
        
    }else{
        
        [self NetWorks];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGray;

    
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    
}

//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"未登录！\n请重新登录后重试！";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        
        [weakSelf presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
        
    };
    [self.noNetWork.btrefresh setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.noNetWork];
}

- (void)noDatas{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.btrefresh.hidden = YES;
    self.noNetWork.titleLabel.text = @"暂无消息！";
    //    self.noNetWork.imageView.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
    //    self.noNetWork.titleLabel.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
    //    self.noNetWork.imageView.frame = CGRectMake(100, screen_height - 340 * KHeight_Scale,screen_width - 200, 160);
    //    self.noNetWork.titleLabel.frame = CGRectMake(40, self.noNetWork.imageView.bottom , screen_width, 40);
    self.noNetWork.btnBlock = ^{
        
    };
    self.noNetWork.btrefresh.hidden = YES;
    [self.view addSubview:self.noNetWork];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations isDeleteMessages:YES completion:nil];
    }
}

#pragma mark - tableView DataSouch
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
//    YJChatCell *cell = (YJChatCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    self.index = indexPath;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YJMessageVC:didSelectConversationModel:)]) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [self.delegate YJMessageVC:self didSelectConversationModel:model];
    } else {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        YJChatVC *viewController = [[YJChatVC alloc] initWithConversationChatter:model.conversation.conversationId conversationType:model.conversation.type];
//        if (model) {
//            <#statements#>
//        }
        viewController.title = model.title;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getter

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)YJMessageVC:(YJMessageVC *)YJMessageVC didSelectConversationModel:(id<IConversationModel>)conversationModel{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        
//        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        YJChatCell *cell = (YJChatCell *)[self.tableView cellForRowAtIndexPath:self.index];
        
        if (conversation) {
          
                UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
                chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#else
                chatController = [[YJChatVC alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#endif
                chatController.title = cell.name.text;
                [self.navigationController pushViewController:chatController animated:YES];
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)YJMessageVC:(YJMessageVC *)YJMessageVC modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    
    EMMessage *message = [model.conversation lastReceivedMessage];
    NSDictionary *msgExt = message.ext;
    
    if (model.conversation.type == EMConversationTypeChat) {

        model.title = msgExt[@"MyNickName"];
        model.avatarURLPath = msgExt[@"MyPicUrl"];
        
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"subject"])
        {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        NSDictionary *ext = conversation.ext;
        model.title = [ext objectForKey:@"subject"];
        imageName = [[ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        model.avatarImage = [UIImage imageNamed:imageName];
    }
    return model;
}

- (NSAttributedString *)YJMessageVC:(YJMessageVC *)YJMessageVC latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        NSString *latestMessageTitle = @"";
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
        
        if (lastMessage.direction == EMMessageDirectionReceive) {
//            NSString *from = lastMessage.from;
//            UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:from];
//            if (profileEntity) {
//                from = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
//            }
//            latestMessageTitle = [NSString stringWithFormat:@"%@: %@", from, latestMessageTitle];
        }
        
        NSDictionary *ext = conversationModel.conversation.ext;
//        if (ext && [ext[kHaveUnreadAtMessage] intValue] == kAtAllMessage) {
//            latestMessageTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"group.atAll", nil), latestMessageTitle];
//            attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
//            [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, NSLocalizedString(@"group.atAll", nil).length)];
//            
//        }
//        else if (ext && [ext[kHaveUnreadAtMessage] intValue] == kAtYouMessage) {
//            latestMessageTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"group.atMe", @"[Somebody @ me]"), latestMessageTitle];
//            attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
//            [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, NSLocalizedString(@"group.atMe", @"[Somebody @ me]").length)];
//        }
//        else {
//            attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
//        }
    }
    
    return attributedStr;
}

- (NSString *)YJMessageVC:(YJMessageVC *)YJMessageVC latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    
    return latestMessageTime;
}




#pragma mark - public

-(void)refresh
{
    [self refreshAndSortView];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
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
