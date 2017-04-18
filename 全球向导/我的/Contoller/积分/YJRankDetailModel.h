//
//  YJRankDetailModel.h
//  全球向导
//
//  Created by SYJ on 2017/4/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRankDetailModel : NSObject

@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , strong) NSString            *  relateId;
@property (nonatomic , strong) NSString            * ID;
@property (nonatomic , assign) NSInteger              flow;
@property (nonatomic , copy) NSString              *  guideId;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString            * operateGv;
@property (nonatomic, strong) NSString             *operateScore;

@end
