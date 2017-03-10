//
//  YJConfirmController.h
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOrderFinshModel.h"
#import "YJSerModel.h"

@interface YJConfirmController : UIViewController

@property (nonatomic, strong) YJOrderFinshModel *model;
@property (nonatomic, strong) YJSerModel *serModel;

@property (nonatomic, strong) NSString *orderID;

//@property (nonatomic, strong) NSString *orderNo; //订单编号

@end
