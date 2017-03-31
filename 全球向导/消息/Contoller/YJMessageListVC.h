//
//  YJMessageListVC.h
//  全球向导
//
//  Created by SYJ on 2017/3/31.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMessageVC.h"

@interface YJMessageListVC : YJMessageVC

@property (strong, nonatomic) NSMutableArray *conversationsArray;


- (void)refresh;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;

@end
