//
//  YJGuideRecommendCell.h
//  全球向导
//
//  Created by SYJ on 2016/11/4.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNFindGuideModel.h"

@interface YJGuideRecommendCell : UITableViewCell

//大图片
@property (nonatomic, strong) UIImageView *imageV;
//标题
@property (nonatomic, strong) UILabel *title;
//小标题
@property (nonatomic, strong) UILabel *descTitle;
//头像
@property (nonatomic, strong) UIImageView *icon;
//名称
@property (nonatomic, strong) UILabel *name;
//职位
@property (nonatomic, strong) UILabel *position;
//浏览量
@property (nonatomic, strong) UILabel *num;
//价格
@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) YJNFindGuideModel *model;


@end
