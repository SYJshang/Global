//
//  UIBarButtonItem+XRZNavitionBar.m
//  仙人掌抢单般
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 muios. All rights reserved.
//

#import "UIBarButtonItem+XRZNavitionBar.h"

@implementation UIBarButtonItem (XRZNavitionBar)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,5,8,16);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // 设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    UINavigationItem *left = [[UINavigationItem alloc]init];
//    left.leftBarButtonItem = barButton;
    return barButton;
}

@end
