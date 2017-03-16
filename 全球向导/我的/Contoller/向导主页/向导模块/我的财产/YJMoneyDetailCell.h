//
//  YJMoneyDetailCell.h
//  全球向导
//
//  Created by SYJ on 2017/3/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMoneyDetailModel.h"

@interface YJMoneyDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *MoneyType;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *yuE;
@property (nonatomic, strong) UILabel *money;

@property (nonatomic, strong) NSDictionary *typeMap;

@property (nonatomic, strong) YJMoneyDetailModel *model;

@end
