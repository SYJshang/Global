//
//  YJNFindGuideModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJNFindGuideModel : NSObject

@property (nonatomic , copy) NSString              * coverPicUrl;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , assign) NSInteger              peopleNumberLimit;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * guideDesc;
@property (nonatomic , copy) NSString              * bigTitle;
@property (nonatomic , copy) NSString              * picUrls;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , assign) NSInteger              soldNumber;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * picIdList;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , assign) NSInteger              guideId;
@property (nonatomic , assign) NSInteger              coverPicId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * smallTitle;
@property (nonatomic , assign) NSInteger              dayNumber;
@property (nonatomic , assign) NSInteger              successNumber;
@property (nonatomic , copy) NSString              * headUrl;
@property (nonatomic , copy) NSString              * guide;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , assign) NSInteger              colNumber;
@property (nonatomic , copy) NSString            *  price;
@property (nonatomic , copy) NSString              * needKnow;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              userId;


@end
