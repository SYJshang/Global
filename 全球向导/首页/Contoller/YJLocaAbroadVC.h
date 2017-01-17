//
//  YJLocaAbroadVC.h
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityName)(NSString *cityname,NSNumber *cityID);

@interface YJLocaAbroadVC : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;


@end
