//
//  YJLunBoModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJLunBoModel : NSObject

@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              upEmployeeId;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , copy) NSString              * picUrl;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              order;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , assign) NSInteger             picId;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , assign) NSInteger              isDisplay;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              addEmployeeId;

@end
