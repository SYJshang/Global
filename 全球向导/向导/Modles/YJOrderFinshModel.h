//
//  YJOrderFinshModel.h
//  全球向导
//
//  Created by SYJ on 2017/2/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSerModel.h"

@interface YJOrderFinshModel : NSObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *personNumber;
@property (nonatomic, strong) NSString *serviceNumber;
@property (nonatomic, strong) NSString *smallTitle;
@property (nonatomic, strong) NSString *showPicUrl;
@property (nonatomic, strong) NSString *bigTitle;

@property (nonatomic, strong) NSArray  *orderDetailList;

@property (nonatomic, strong) NSString *orderId;

//phone = 123456;
//remark = Sdfgh;
//totalMoney = 300;
//orderNo = 0139;
//personNumber = 3;
//orderDetailList = (
//
//                   );
//serviceNumber = 3;

@end
