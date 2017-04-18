//
//  YJIntegraModel.h
//  全球向导
//
//  Created by SYJ on 2017/4/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJRankDetailModel.h"

@interface YJIntegraModel : NSObject

@property (nonatomic , copy) NSString              * headUrl;
@property (nonatomic , copy) NSString              *totalUseScore;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * yearUseScore;
@property (nonatomic , strong) NSArray             * scoreDetailList;

@end
