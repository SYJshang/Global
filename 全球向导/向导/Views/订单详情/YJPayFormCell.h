//
//  YJPayFormCell.h
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJPayFormCell : UITableViewCell

//支付图标
@property (nonatomic, strong) UIImageView *icon;
//name
@property (nonatomic, strong) UILabel *payName;
//是否绑定
@property (nonatomic, strong) UILabel *isReal;
//进入
@property (nonatomic, strong) UIImageView *access;

@end
