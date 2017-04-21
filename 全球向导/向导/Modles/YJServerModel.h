//
//  YJServerModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/13.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJServerModel : NSObject

@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , assign) NSInteger              peopleNumberLimit;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              relateDayNumber;
@property (nonatomic , assign) NSInteger              soldNumber;
@property (nonatomic , assign) NSInteger              version;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * iconUrl;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              guideId;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , assign) NSInteger              successNumber;
@property (nonatomic , assign) NSInteger              tempId;
@property (nonatomic , assign) NSInteger              isGuidePrice;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , assign) NSInteger              iconPicId;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , strong) NSString            *  price;

@end
