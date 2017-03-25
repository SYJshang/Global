//
//  YJGuideModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGuideModel : NSObject

@property (nonatomic , strong) NSString            *  ID;
@property (nonatomic , copy) NSString              * headUrl;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , assign) NSInteger              sex;
@property (nonatomic , copy) NSString              * coverPhotoUrl;
@property (nonatomic , copy) NSString              * guideDesc;
@property (nonatomic , strong) NSString            * type;
@property (nonatomic , strong) NSString            *  userId;
@property (nonatomic , copy) NSString              * headPicId;
@property (nonatomic , copy) NSString              * motto;
@property (nonatomic , copy) NSString              * summary;
@property (nonatomic , copy) NSString              * cpPicId;
@property (nonatomic , assign) NSInteger              npStatus;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , copy) NSString            *  status;
@property (nonatomic, strong) NSString            *guideId;


@end
