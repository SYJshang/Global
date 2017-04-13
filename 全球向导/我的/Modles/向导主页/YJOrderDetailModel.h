//
//  YJOrderDetailModel.h
//  全球向导
//
//  Created by SYJ on 2017/3/10.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJOrderDetailModel : NSObject


@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * wechat;
@property (nonatomic , copy) NSString              * flow;
@property (nonatomic , copy) NSString              * revokeTime;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * orderDetailList;
@property (nonatomic , copy) NSString              * payTime;
@property (nonatomic , copy) NSString              * payIp;
@property (nonatomic , copy) NSString              * isCallRefund;
@property (nonatomic , copy) NSString              * buyerCrt;
@property (nonatomic , copy) NSString              * confirmTime;
@property (nonatomic , copy) NSString              * payMethod;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * endBuyTime;
@property (nonatomic , copy) NSString              * bigTitle;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              isAutoConfirm;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , copy) NSString              * showPicUrl;
@property (nonatomic , assign) NSInteger              guideArn;
@property (nonatomic , copy) NSString              * aheadTime;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              serviceNumber;
@property (nonatomic , copy) NSString              * payiOrderNo;
@property (nonatomic , assign) NSInteger              guideId;
@property (nonatomic , copy) NSString              * guideArt;
@property (nonatomic , assign) NSInteger              personNumber;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString              * smallTitle;
@property (nonatomic , assign) NSInteger              refundMoney;
@property (nonatomic , copy) NSString              * payiPayTime;
@property (nonatomic , assign) NSInteger              buyerArn;
@property (nonatomic , copy) NSString              * beginDate;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * endLimitTime;
@property (nonatomic , copy) NSString              * totalMoney;
@property (nonatomic , assign) NSInteger              recId;
@property (nonatomic , strong) NSString            *  buyerId;
@property (nonatomic , copy) NSString              * buyerArt;
@property (nonatomic , copy) NSString              * beginLimitTime;
@property (nonatomic , copy) NSString              * waitRevokeTime;
@property (nonatomic , copy) NSString              * buyIp;
@property (nonatomic , assign) NSInteger              closeType;
@property (nonatomic , assign) NSInteger              version;
@property (nonatomic , copy) NSString              * receiveTime;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , assign) NSInteger              successType;
@property (nonatomic , copy) NSString              * limitTime;
@property (nonatomic , assign) NSInteger              guideType;
@property (nonatomic , copy) NSString              * guideCrt;
@property (nonatomic , copy) NSString              * serviceDates;
@property (nonatomic , copy) NSString              * beginBuyTime;
@property (nonatomic , copy) NSString              * buyTime;
@property (nonatomic , assign) NSInteger              revokeStatus;
@property (nonatomic, strong) NSString             *payMethodName;
@property (nonatomic, strong) NSString             *successTypeName;
@property (nonatomic, strong) NSString             *closeTypeName;
@property (nonatomic, strong) NSString             *statusName;



@end
