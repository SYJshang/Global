//
//  YJFindCollectCell.h
//  全球向导
//
//  Created by SYJ on 2017/2/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNearbyModel.h"

@interface YJShareCollectCell : UITableViewCell

//大图片
@property (nonatomic, strong) UIImageView *imageV;
//标题
@property (nonatomic, strong) UILabel *title;
//小标题
@property (nonatomic, strong) UILabel *descTitle;

@property (nonatomic, strong) YJNearbyModel *model;

@end
