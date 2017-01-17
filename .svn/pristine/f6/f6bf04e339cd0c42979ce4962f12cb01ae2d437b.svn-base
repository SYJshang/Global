//
//  YJGuideIntroCell.h
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJGuideModel.h"

@protocol IntroDetailDelegate <NSObject>

- (void)introDetail:(BOOL)Detail;

@end

@interface YJGuideIntroCell : UITableViewCell

/**
 向导简介
 */
@property (nonatomic, strong) UILabel *introLab;
/**
 展开按钮
 */
@property (nonatomic, strong) YJDIYButton *unfoldBtn;

@property (nonatomic, weak)  id <IntroDetailDelegate> delegate;


-(void)configCellWithText:(YJGuideModel *)text;
+(CGFloat)cellHegith:(YJGuideModel *)text;

@end
