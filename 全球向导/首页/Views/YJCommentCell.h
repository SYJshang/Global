//
//  YJCommentCell.h
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJEvaModel.h"

@interface YJCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;//头像
@property (nonatomic, strong) UILabel *nameLab;//名称
@property (nonatomic, strong) UILabel *timeLab;//时间
@property (nonatomic, strong) UILabel *textLab;//评论内容

@property (nonatomic, strong) UIButton *btn; //评价


-(void)configCellWithText:(YJEvaModel *)text;
+(CGFloat)cellHegith:(YJEvaModel *)text;

@property (nonatomic, strong) YJEvaModel *model;


@end
