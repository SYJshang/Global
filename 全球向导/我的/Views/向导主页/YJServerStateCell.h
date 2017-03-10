//
//  YJServerStateCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJServerStateModle.h"

@protocol editBtnClickPush <NSObject>
@optional
-(void)editClickPush:(UIButton *)sender;
@end

@interface YJServerStateCell : UITableViewCell

//服务类型icon
@property (nonatomic, strong) UIImageView *icon;
//服务类型
@property (nonatomic, strong) UILabel *server;
//描述
@property (nonatomic, strong) UILabel *descLab;
//价格
@property (nonatomic, strong) UILabel *priceLab;
//状态按钮
@property (nonatomic, strong) UIButton *stateBtn;
//编辑按钮
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, weak) id <editBtnClickPush>delegate;

@property (nonatomic, strong) YJServerStateModle *model;


@end
