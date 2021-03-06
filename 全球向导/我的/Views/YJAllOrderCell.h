//
//  YJAllOrderCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOrderListModel.h"
#import "YJEvaWaitModel.h"

@protocol YJBtnClickEvE <NSObject>
@optional
-(void)btnDidClickPlusButton:(UIButton *)ViewTag;
@end

@interface YJAllOrderCell : UITableViewCell

@property (nonatomic,weak) id<YJBtnClickEvE> delegate;


/*
 *  记录订单状态
 */

@property (nonatomic, assign) int orderState;

/*
 *  订单编号
 */
@property (nonatomic, strong) UILabel *orderLab;
 /*
 *  状态
 */
@property (nonatomic, strong) UILabel *stateLab;
/*
 *头像
 */
@property (nonatomic, strong) UIImageView *icon;
/*
 *  名称
 */
@property (nonatomic, strong) UILabel *nameLab;
/*
 *  描述
 */
@property (nonatomic, strong) UILabel *descLab;
/*
 *  价格
 */
@property (nonatomic, strong) UILabel *priceLab;
/*
 *  取消订单
 */
@property (nonatomic, strong) UIButton *disOrder;
/*
 *  联系向导
 */
@property (nonatomic, strong) UIButton *relation;
/*
 *  购买
 */
@property (nonatomic, strong) UIButton *buyOrder;

//数据模型
@property (nonatomic, strong) YJOrderListModel *model;
@property (nonatomic, strong) YJEvaWaitModel *evaModel;


@end
