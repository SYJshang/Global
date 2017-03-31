//
//  YJChatVC.h
//  全球向导
//
//  Created by SYJ on 2017/3/23.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface YJChatVC : EaseMessageViewController<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;


@end
