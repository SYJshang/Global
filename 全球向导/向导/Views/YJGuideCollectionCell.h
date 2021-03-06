//
//  YJGuideCollectionCell.h
//  全球向导
//
//  Created by SYJ on 2016/10/27.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJGuideModel.h"

@interface YJGuideCollectionCell : UICollectionViewCell
//图片
@property (nonatomic, strong) UIImageView *imgV;
//头像
@property (nonatomic, strong) UIImageView *icon;
//姓名
@property (nonatomic, strong) UILabel *name;
//职位
@property (nonatomic, strong) UILabel *positionLab;

@property (nonatomic, strong) YJGuideModel *guideModel;



@end
