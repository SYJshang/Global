//
//  YJRankModel.h
//  全球向导
//
//  Created by SYJ on 2017/4/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRankModel : NSObject

//gradeName = 实习向导;
//nextGradeName = 一星向导;
//headUrl = http://tour2.oss-cn-hangzhou.aliyuncs.com/cps/22/1486956597435804;
//realName = SYJ;
//totalUseGv = 0;
//grade = 1;
//preGrade = <null>;
//preGradeName = <null>;
//yearUseGv = 0;
//nextGrade = 2;

@property (nonatomic, strong) NSString *gradeName;
@property (nonatomic, strong) NSString *nextGradeName;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *totalUseGv;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, strong) NSString *yearUseGv;
@property (nonatomic, assign) NSInteger nextGrade;
@property (nonatomic, strong) NSString *preGrade;
@property (nonatomic, strong) NSString *preGradeName;


@end
