//
//  YJPriceModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJPriceModel : NSObject

@property (nonatomic , strong) NSString            *  ID;
@property (nonatomic , copy) NSString              * typeName;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , copy) NSString              * statusValue;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * valueId;
@property (nonatomic , assign) NSInteger              deleteFlag;
@property (nonatomic , assign) NSInteger              order;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , copy) NSString              * value2;
@property (nonatomic , assign) NSInteger              isDisplay;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * remarks;

@end
