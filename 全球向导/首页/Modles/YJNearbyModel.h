//
//  YJNearbyModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJNearbyModel : NSObject

@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              coverPicId;
@property (nonatomic , copy) NSString              * version;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , copy) NSString              * picUrls;
@property (nonatomic , copy) NSString              * bigTitle;
@property (nonatomic , copy) NSString              * picIdList;
@property (nonatomic , assign) NSInteger              colNumber;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * ip;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , copy) NSString              * coverPicUrl;
@property (nonatomic , copy) NSString              * smallTitle;

@end
