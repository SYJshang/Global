//
//  YJEveListCell.h
//  全球向导
//
//  Created by SYJ on 2017/4/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJEvaModel.h"


@protocol ImageDelegate <NSObject>

-(void)checkImage:(NSString*)imgname;

@end

@interface YJEveListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;//头像
@property (nonatomic, strong) UILabel *nameLab;//名称
@property (nonatomic, strong) UILabel *timeLab;//时间
@property (nonatomic, strong) UILabel *textLab;//评论内容
@property (nonatomic, strong) UIButton *btn; //评价

@property (nonatomic, strong) NSString *imgStr;

@property (nonatomic, strong) UIView *view;

-(void)configCellWithText:(YJEvaModel *)text;
+(CGFloat)cellHegith:(YJEvaModel *)text;

@property (nonatomic, strong) YJEvaModel *model;

@property (weak, nonatomic) id<ImageDelegate>myDelegate;


@end
