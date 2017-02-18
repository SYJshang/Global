
//
//  YJPriceModel.m
//  全球向导
//
//  Created by SYJ on 2017/1/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJPriceModel.h"

@implementation YJPriceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id",
             @"valueId" : @"value"
             };
}

@end
