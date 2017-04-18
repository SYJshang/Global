//
//  YJIntrgralDetailCell.h
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJRankDetailModel.h"


@interface YJIntrgralDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *intrLab;

@property (nonatomic, strong) UILabel *orderNo;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) YJRankDetailModel *model;

@property (nonatomic, assign) NSInteger isIntegral;


@end
