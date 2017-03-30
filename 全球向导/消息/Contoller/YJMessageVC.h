/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import <UIKit/UIKit.h>



@class YJMessageVC;

@protocol YJMessageVCDelegate <NSObject>

/*!
 @method
 @brief 获取点击会话列表的回调
 @discussion 获取点击会话列表的回调后,点击会话列表用户可以根据conversationModel自定义处理逻辑
 @param conversationListViewController 当前会话列表视图
 @会话模型
 @ result
 */
- (void)YJMessageVC:(YJMessageVC *)YJMessageVC
            didSelectConversationModel:(id<IConversationModel>)conversationModel;

@optional

@end

@protocol YJMessageVCDataSource <NSObject>

/*!
 @method
 @brief 构建实现协议IConversationModel的model
 @discussion 用户可以创建实现协议IConversationModel的自定义conversationModel对象，按照业务需要设置属性值
 @param conversationListViewController 当前会话列表视图
 @param conversation 会话对象
 @result 返回实现协议IConversationModel的model对象
 */
- (EaseConversationModel *)YJMessageVC:(YJMessageVC *)YJMessageVC
                                    modelForConversation:(EMConversation *)conversation;

@optional

/*!
 @method
 @brief 获取最后一条消息显示的内容
 @discussion 用户根据conversationModel实现,实现自定义会话中最后一条消息文案的显示内容
 @para当前会话列表视图
 @会话模型
 @result 返回用户最后一条消息显示的内容
 */
- (NSAttributedString *)YJMessageVC:(YJMessageVC *)YJMessageVC
                latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel;

/*!
 @method
 @brief 获取最后一条消息显示的时间
 @discussion 用户可以根据conversationModel,自定义实现会话列表中时间文案的显示内容
 @param 当前会话列表视图
 @会话模型
 @result 返回用户最后一条消息时间的显示文案
 */
- (NSString *)YJMessageVC:(YJMessageVC *)YJMessageVC
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel;

@end


@interface YJMessageVC : EaseRefreshTableViewController <EMChatManagerDelegate,EMGroupManagerDelegate>

@property (weak, nonatomic) id<YJMessageVCDelegate> delegate;
@property (weak, nonatomic) id<YJMessageVCDataSource> dataSource;

/*!
 @method
 @brief 下拉加载更多
 @ discussion
 @ result
 */
- (void)tableViewDidTriggerHeaderRefresh;

/*!
 @method
 @brief 内存中刷新页面
 @ discussion
 @ result
 */
- (void)refreshAndSortView;

@end
