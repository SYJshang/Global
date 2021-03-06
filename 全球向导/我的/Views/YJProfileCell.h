//
//  YJProfileCell.h
//  全球向导
//
//  Created by SYJ on 2016/11/4.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YJBtnClickPublic <NSObject>
@optional
-(void)btnDidClickPlusButton:(NSInteger )ViewTag;
@end


@interface YJProfileCell : UITableViewCell

@property (nonatomic,weak) id<YJBtnClickPublic> delegate;


//第一个按钮图片
@property (nonatomic, strong) UIImageView *publishImg;
//第一个标题
@property (nonatomic, strong) UILabel *publishLab;

//第二个按钮图片
@property (nonatomic, strong) UIImageView *collectImg;
//第二个标题
@property (nonatomic, strong) UILabel *collectLab;

//第三个按钮图片
@property (nonatomic, strong) UIImageView *insureImg;
//第三个标题
@property (nonatomic, strong) UILabel *insureLab;




@end
