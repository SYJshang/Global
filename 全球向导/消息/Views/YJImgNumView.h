//
//  YJImgNumView.h
//  全球向导
//
//  Created by SYJ on 2017/3/30.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJImgNumView : UIView

/** @brief 头像图片 */
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

/** @brief 角标数 */
@property (nonatomic) NSInteger badge;

/** @brief 是否显示角标 */
@property (nonatomic) BOOL showBadge;

/** @brief 头像圆角 */
@property (nonatomic) CGFloat imageCornerRadius UI_APPEARANCE_SELECTOR;

/** @brief 角标控件宽度 */
@property (nonatomic) CGFloat badgeSize UI_APPEARANCE_SELECTOR;

/** @brief 角标字体 */
@property (nonatomic) UIFont *badgeFont UI_APPEARANCE_SELECTOR;

/** @brief 角标文字颜色 */
@property (nonatomic) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;

/** @brief 角标背景色 */
@property (nonatomic) UIColor *badgeBackgroudColor UI_APPEARANCE_SELECTOR;


@end
