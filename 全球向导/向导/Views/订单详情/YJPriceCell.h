//
//  YJPriceCell.h
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOrderFinshModel.h"

@interface YJPriceCell : UITableViewCell

@property (nonatomic, strong) UILabel *allPrice;

//@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) YJOrderFinshModel *model;

@end
