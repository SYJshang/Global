//
//  YJMoneyDetailModel.h
//  全球向导
//
//  Created by SYJ on 2017/3/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJMoneyDetailModel : NSObject

@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger flow;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *useMoney;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *addIp;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *payiOrderNo;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *flowFlag;


@end
