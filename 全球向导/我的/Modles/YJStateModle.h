//
//  YJStateModle.h
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJStateModle : NSObject

@property (strong,nonatomic)NSString * timeStr;
@property (strong,nonatomic)NSString * titleStr;
@property (strong,nonatomic)NSString * detailSrtr;

-(instancetype)initData:(NSDictionary *)dic;



@end
