//
//  YJUsreInfoModel.h
//  全球向导
//
//  Created by SYJ on 2016/12/28.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJUsreInfoModel : NSObject

//id = 8;
//headUrl = <null>;
//upTime = 2016-12-23 16:18:28;
//addIp = 192.168.1.133;
//mobile = 18860233121;
//loginTimes = 30;
//upIp = 192.168.1.133;
//lastTime = 2016-12-28 11:33:05;
//lastIp = 192.168.1.133;
//headPicId = <null>;
//payPwdStatus = 0;
//nickName = <null>;
//addTime = 2016-12-23 16:18:28;
//previousTime = 2016-12-28 10:43:25;
//previousIp = 192.168.1.133;
//email = <null>;
//status = 1;

//id
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *headUrl; //头像url
@property (nonatomic, strong) NSString *upTime; //登录时间
@property (nonatomic, assign) int loginTimes; //登录次数
@property (nonatomic, strong) NSString *addIp; //ip地址
@property (nonatomic, strong) NSString *mobile; //手机号
@property (nonatomic, strong) NSString *upIp; //登录ip
@property (nonatomic, strong) NSString *lastTime; //上次登录时间
@property (nonatomic, strong) NSString *lastIp; //上次登录ip
@property (nonatomic, assign) long int headPicId; //头像公共图片id
@property (nonatomic, assign) int payPwdStatus; //支付状态
@property (nonatomic, strong) NSString *nickName; //昵称
@property (nonatomic, strong) NSString *addTime; //添加时间
@property (nonatomic, strong) NSString *previousTime; //上次返回时间
@property (nonatomic, strong) NSString *previousIp; //上次返回ip
@property (nonatomic, strong) NSString *email; //邮箱
@property (nonatomic, assign) int status;
@property (nonatomic, strong) NSString *imPwd;
@property (nonatomic, strong) NSString *userNo;
@property (nonatomic, strong) NSString *lastSignDate;


@end
