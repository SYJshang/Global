//
//  YJHomeHotCityModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YJCityModel : NSObject

/**
 城市id
 */
@property (nonatomic, strong) NSString *ID;
/**
 城市名称
 */
@property (nonatomic, strong) NSString *name;
/**
 洲id
 */
@property (nonatomic, assign) int contId;
/**
 国家id
 */
@property (nonatomic, assign) int countryId;
/**
 省id
 */
@property (nonatomic, assign) int provinceId;
/**
 排序
 */
@property (nonatomic, assign) int order;
/**
 首字母
 */
@property (nonatomic, strong) NSString *initial;
/**
 是否开放
 */
@property (nonatomic, assign) int isOpen;
/**
 是否热门
 */
@property (nonatomic, assign) int isHot;
/**
 城市标题
 */
@property (nonatomic, strong) NSString *title;
/**
 城市封面图片
 */
@property (nonatomic, strong) NSString *coverUrl;
/**
 封面图片id
 */
@property (nonatomic, assign) long int coverPicId;
/**
 温度
 */
@property (nonatomic, strong) NSString *temp;
/**
 天气
 */
@property (nonatomic, strong) NSString *weather;


@end
