//
//  YJSearchCity.h
//  全球向导
//
//  Created by SYJ on 2017/1/5.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJSearchCity : NSObject
@property (copy, nonatomic) NSString *name;
// 搜索联系人的方法 (拼音/拼音首字母缩写/汉字)
+ (NSArray<YJSearchCity *> *)searchText:(NSString *)searchText inDataArray:(NSArray<YJSearchCity *> *)dataArray;


@end
