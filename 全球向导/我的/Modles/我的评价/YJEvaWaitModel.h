//
//  YJEvaWaitModel.h
//  全球向导
//
//  Created by SYJ on 2017/2/23.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJEvaWaitModel : NSObject


@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *buyerId;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *recId;
@property (nonatomic, strong) NSString *bigTitle;
@property (nonatomic, strong) NSString *smallTitle;
@property (nonatomic, strong) NSString *showPicUrl;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *buyTime;
@property (nonatomic, strong) NSString *isShowPic;
@property (nonatomic, strong) NSString *eva;
@property (nonatomic, strong) NSString *picIds;//`pic_ids 晒单图片id,多张图片用逗号分隔',
@property (nonatomic, strong) NSString *picUrls;//'晒单图片url,多张图片用逗号分隔'



@end
