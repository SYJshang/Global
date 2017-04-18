//
//  YJRankTopCell.h
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJRankModel.h"


@interface YJRankTopCell : UITableViewCell


/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *icon;

/**
 *  当前等级
 */
@property (nonatomic, strong) UIImageView *rankIcon;


/**
 *  当前等级前一个等级
 */
@property (nonatomic, strong) UIImageView *beforeRank;

/**
 *  当前等级之后一个等级
 */
@property (nonatomic, strong) UIImageView *lastRank;

/**
 *  用户编号
 */
@property (nonatomic, strong) UILabel *nameNoLab;

/**
 *  当前用户积分
 */
@property (nonatomic, strong) UILabel *integralLab;


/**
 *  明细
 */
@property (nonatomic, strong) UIButton *detailBtn;

@property (nonatomic, strong) YJRankModel *model;




@end
