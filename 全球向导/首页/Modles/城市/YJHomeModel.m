//
//  YJCountryHomeModel.m
//  全球向导
//
//  Created by SYJ on 2017/1/5.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJHomeModel.h"

@implementation YJHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"internalHotCityList" : @"YJCityModel",
              @"externalHotCityList" : @"YJCityModel",
              @"contList" : @"YJConitineModel"
              };
}


@end
