//
//  YJAreaMianVC.h
//  全球向导
//
//  Created by SYJ on 2017/1/4.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityName)(NSString *cityname,NSNumber *cityID);

@interface YJAreaMianVC : UIViewController

@property (nonatomic, copy) CityName returnBlocks;

- (void)returnTitle:(CityName)block;




@end
