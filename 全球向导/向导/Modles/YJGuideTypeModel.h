//
//  YJGuideTypeModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/11.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGuideTypeModel : NSObject

/**
 向导类型id
 */
@property (nonatomic , strong) NSString            *  ID;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) NSInteger              isDisplay;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , copy) NSString              * statusValue;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , assign) NSInteger              deleteFlag;
@property (nonatomic , assign) NSInteger              order;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , copy) NSString              * value2;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * typeName;

/**
 向导类型
 */
@property (nonatomic , copy) NSString              * name;

@end
