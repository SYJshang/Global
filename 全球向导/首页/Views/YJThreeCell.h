//
//  YJThreeCell.h
//  全球向导
//
//  Created by SYJ on 2016/10/27.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJGuideModel.h"

@interface YJThreeCell : UITableViewCell

@property (nonatomic, assign) NSInteger state;

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

@property (nonatomic, strong) NSDictionary *guideType;
@property (nonatomic, strong) YJGuideModel *guideModel;

@end
