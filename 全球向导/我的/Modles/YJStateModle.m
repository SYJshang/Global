//
//  YJStateModle.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJStateModle.h"

@implementation YJStateModle

-(instancetype)initData:(NSDictionary *)dic{
    if (self=[super init]) {
        self.timeStr = [dic objectForKey:@"timeStr"];
        self.titleStr = [dic objectForKey:@"titleStr"];
        self.detailSrtr = [dic objectForKey:@"detailSrtr"];
    }
    return self;
}

@end
