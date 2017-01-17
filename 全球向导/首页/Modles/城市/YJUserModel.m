
//
//  YJUserModel.m
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJUserModel.h"

@implementation YJUserModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"linkList" : @"YJLunBoModel",
              @"userRecList" : @"YJNearbyModel",
              @"guide" : @"YJGuideModel",
              @"guideRec" : @"YJNewFindModel"
              };
}

@end
