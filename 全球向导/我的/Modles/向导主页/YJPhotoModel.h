//
//  YJPhotoModel.h
//  全球向导
//
//  Created by SYJ on 2017/3/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJPhotoModel : NSObject

//`id` bigint(20) NOT NULL AUTO_INCREMENT,
//`pic_id` bigint(20) NOT NULL COMMENT '向导图片空间的图片id',
//`guide_id` bigint(20) NOT NULL COMMENT '向导id',
//`album_id` bigint(20) NOT NULL COMMENT '相册id',
//`url` varchar(200) NOT NULL COMMENT 'url',
//`add_time` datetime NOT NULL,
//`up_time` datetime NOT NULL,

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *picId;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picNumber;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *upTime;
@property (nonatomic, strong) NSString *coverPicUrl;

@end
