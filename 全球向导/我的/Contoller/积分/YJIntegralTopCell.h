//
//  YJIntegralTopCell.h
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJIntegraModel.h"

@interface YJIntegralTopCell : UITableViewCell

/**
 *  头像
 */

@property (nonatomic, strong) UIImageView *icon;

/**
 *  用户编号
 */
@property (nonatomic, strong) UILabel *NoLab;

/**
 *  可用积分
 */
@property (nonatomic, strong) UILabel *userInge;

/**
 *  过期积分
 */
@property (nonatomic, strong) UILabel *pastInteg;

@property (nonatomic, strong) YJIntegraModel *model;

@end
