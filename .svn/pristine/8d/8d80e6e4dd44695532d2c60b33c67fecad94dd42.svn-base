
//
//  YJBNetWorkNotifionTool.m
//  全球向导
//
//  Created by SYJ on 2017/1/10.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJBNetWorkNotifionTool.h"

@implementation YJBNetWorkNotifionTool

+ (NSString *)stringFormStutas{
    
    Reachability *rea = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [rea currentReachabilityStatus];
    NSString *str;
    if (status == ReachableViaWWAN){
            str = @"1";
    }else if (status == ReachableViaWiFi){
            str = @"2";
    }else if (status == NotReachable){
            str = @"3";
    }else{
            str = @"4";
    }
    
    return str;
    
}

@end
