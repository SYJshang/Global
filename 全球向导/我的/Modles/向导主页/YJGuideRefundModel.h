//
//  YJGuideRefundModel.h
//  全球向导
//
//  Created by SYJ on 2017/3/10.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGuideRefundModel : NSObject

@property (nonatomic , assign) NSInteger              orderId;
@property (nonatomic , copy) NSString              * auditRemark;
@property (nonatomic , assign) NSInteger              orderType;
@property (nonatomic , strong) NSString            *  ID;
@property (nonatomic , assign) NSInteger              callRefundStatus;
@property (nonatomic , copy) NSString              * payMethodName;
@property (nonatomic , copy) NSString              * applyTime;
@property (nonatomic , copy) NSString              * beginRefundTime;
@property (nonatomic , copy) NSString              * showPicUrl;
@property (nonatomic , copy) NSString              * smallTitle;
@property (nonatomic , assign) NSInteger              payMethod;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , strong) NSString            *  buyerId;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * auditEmployeeId;
@property (nonatomic , copy) NSString              * refundTime;
@property (nonatomic , copy) NSString              * typeName;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * auditStatus;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * beginApplyTime;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , assign) NSInteger              recId;
@property (nonatomic , copy) NSString              * refundNo;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * statusName;
@property (nonatomic , assign) NSInteger              tradeMoney;
@property (nonatomic , copy) NSString              * endApplyTime;
@property (nonatomic , assign) NSInteger              guideId;
@property (nonatomic , assign) NSInteger              refundMoney;
@property (nonatomic , copy) NSString              * bigTitle;
@property (nonatomic , copy) NSString              * refundReason;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic, assign) NSInteger            serviceNumber;


@end
