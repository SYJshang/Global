//
//  UINavigationItem+XRZItemTitle.m
//  仙人掌抢单般
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 muios. All rights reserved.
//

#import "UINavigationItem+XRZItemTitle.h"

@implementation UILabel (XRZItemTitle)


+ (UILabel *)titleWithColor:(UIColor *)color title:(NSString *)title font:(CGFloat)font{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width / 2 - 100,0, 200, 44)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textColor = color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    return titleLabel;
}


@end
