//
//  YJPhotoLsitModel.h
//  全球向导
//
//  Created by SYJ on 2017/3/2.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJPhotoLsitModel : NSObject

//addTime = 2017-03-01 18:06:08;
//upTime = 2017-03-01 18:06:08;
//albumId = 17;
//id = 29;
//picId = 63;
//version = <null>;
//guideId = 11;
//page = <null>;
//ip = <null>;
//url = http://tour2.oss-cn-hangzhou.aliyuncs.com/gps/11/1488362767141976-3;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *upTime;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *picId;





@end
