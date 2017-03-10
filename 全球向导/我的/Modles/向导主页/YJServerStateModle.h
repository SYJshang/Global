//
//  YJServerStateModle.h
//  全球向导
//
//  Created by SYJ on 2017/3/7.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJServerStateModle : NSObject


@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *soldNumber;
@property (nonatomic, strong) NSString *successNumber;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *upTime;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *peopleNumberLimit;
@property (nonatomic, strong) NSString *relateDayNumber;
@property (nonatomic, strong) NSString *tempId;
@property (nonatomic, strong) NSString *isGuidePrice;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *iconPicId;
@property (nonatomic, strong) NSString *number;

@end
