//
//  YJNewFindModel.h
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJNewFindModel : NSObject

//guide
//realName
//type
//headUrl
//bigTitle
//smallTitle
//coverPicUrl
//colNumber
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *bigTitle;
@property (nonatomic, strong) NSString *smallTitle;
@property (nonatomic, strong) NSString *coverPicUrl;
@property (nonatomic, strong) NSString *colNumber;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *userId;


@property (nonatomic, strong) NSDictionary *guide;



@end
