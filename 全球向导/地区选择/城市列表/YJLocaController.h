//
//  YJLocaController.h
//  全球向导
//
//  Created by SYJ on 2016/10/25.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface YJLocaController : UIViewController

typedef void(^ReturnCityName)(NSString *cityname);

@interface YJLocaController : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;


@end
