//
//  YJGOrderCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DisAndReceingClickPush <NSObject>
@optional
-(void)btnClickEnvent:(NSInteger)tag;
@end

@interface YJGOrderCell : UITableViewCell

@property (nonatomic, weak) id <DisAndReceingClickPush>delegate;

//订单号
@property (nonatomic, strong) UILabel *orderNum;
//倒计时时间
@property (nonatomic, strong) UILabel *timeLab;
//时间icon
@property (nonatomic, strong) UIImageView *timeIcon;
//状态
@property (nonatomic, strong) UILabel *stateLab;
//预订人名称icon
@property (nonatomic, strong) UIImageView *reserveIcon;
//预订人名称
@property (nonatomic, strong) UILabel *reserveLab;
//总共时长
@property (nonatomic, strong) UIImageView *allTimeIcon;
//总共时长icon
@property (nonatomic, strong) UILabel *allTimeLab;
//发现名称icon
@property (nonatomic, strong) UIImageView *findIcon;
//发现名称
@property (nonatomic, strong) UILabel *findLab;
//接单
@property (nonatomic, strong) UIButton *receiveBtn;
//联系用户
@property (nonatomic, strong) UIButton *relationBtn;
//拒绝接单
@property (nonatomic, strong) UIButton *refuseBtn;







@end
