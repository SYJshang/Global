//
//  UIBarButtonItem+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
//#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(8, 14, 16, 16);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    return leftItem;
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    // 设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)font
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(8, 14, 40, 16);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    return leftItem;

}
@end
