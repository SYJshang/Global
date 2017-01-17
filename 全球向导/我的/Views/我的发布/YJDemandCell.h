//
//  YJDemandCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/29.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJDemandCell : UITableViewCell

/**
 类型
 */
@property (nonatomic, strong) UILabel *stateLab; //类型
@property (nonatomic, strong) UILabel *priceLab; //价格
@property (nonatomic, strong) UILabel *timeLab;  //时间
@property (nonatomic, strong) UILabel *position; //地点
@property (nonatomic, strong) UILabel *nameLab;  //名称
@property (nonatomic, strong) UIButton *cancelLab; //取消发布按钮

@end
