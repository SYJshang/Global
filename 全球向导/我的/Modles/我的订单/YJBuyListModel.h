//
//  YJBuyListModel.h
//  全球向导
//
//  Created by SYJ on 2017/2/22.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJBuyListModel : NSObject

//ID,
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *recId;
@property (nonatomic, strong) NSString *showPicUrl;
@property (nonatomic, strong) NSString *bigTitle;
@property (nonatomic, strong) NSString *smallTitle;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *buyerId;
@property (nonatomic, strong) NSString *employeeId;
@property (nonatomic, strong) NSString *tradeMoney;
@property (nonatomic, strong) NSString *refundMoney;
@property (nonatomic, strong) NSString *applyTime;
@property (nonatomic, strong) NSString *refundTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *refundReason;
@property (nonatomic, strong) NSString *handleResult;
@property (nonatomic, strong) NSString *payMethod;

@end
