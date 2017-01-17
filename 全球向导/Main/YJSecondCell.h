//
//  YJSecondCell.h
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNearbyModel.h"

@interface YJSecondCell : UITableViewCell

//大图片
@property (nonatomic, strong) UIImageView *imageV;
//标题
@property (nonatomic, strong) UILabel *title;
//小标题

@property (nonatomic, strong) UILabel *descTitle;
//浏览量
@property (nonatomic, strong) UILabel *num;

@property (nonatomic, strong) YJNearbyModel *shareList;
@property (nonatomic, strong) NSDictionary  *guideType;


@end
