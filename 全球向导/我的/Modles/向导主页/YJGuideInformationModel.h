//
//  YJGuideInformationModel.h
//  全球向导
//
//  Created by SYJ on 2016/12/30.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGuideInformationModel : NSObject

//addTime = 1479349468000;
//areaId = 0;
//beginPrice = "<null>";
//certPicId = 3;
//certUrl = "http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/1/1478679731561743";
//cityId = 3567;
//contId = 4;
//countryId = 3;
//coverPhotoUrl = "http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/1/1478679339995091";
//cpPicId = 1;
//curId = 2;
//dlTime = d2;
//driverName = d1;
//endPrice = "<null>";
//guideCarList =         (
//);
//guideCars = "<null>";
//hasCar = 1;
//headPicId = 2;
//headUrl = "http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/1/1478679664744571";
//icPicId1 = 113;
//icPicId2 = 114;
//id = 3;
//idCard = 330206198212023419;
//idCardUrl1 = "http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/1/1479349419959405";
//idCardUrl2 = "http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/1/1479349424224669";
//ip = "<null>";
//motto = t3;
//nativePlace = c;
//npStatus = 0;
//page = "<null>";
//perPlace = "<null>";
//price = 230;
//provinceId = 0;
//quali = 3;
//realName = a;
//sex = 0;
//status = 2;
//summary = t4;
//type = 1;
//unknownArea = "<null>";
//upTime = 1482993840000;
//userId = 1;
//version = "<null>";

@property (nonatomic, strong) NSString *coverPhotoUrl;
@property (nonatomic, strong) NSString *headUrl;

/**
 真实姓名
 */
@property (nonatomic, strong) NSString *realName;
/**
 生日
 */
@property (nonatomic, strong) NSString *birth;

/**
 性别
 */
@property (nonatomic, assign) int sex;

/**
 向导类型
 */
@property (nonatomic, strong) NSString *typeName;


/**
 目前身份
 */
@property (nonatomic, assign) int curId;

/**
 座右铭
 */
@property (nonatomic, strong) NSString *motto;






@end
