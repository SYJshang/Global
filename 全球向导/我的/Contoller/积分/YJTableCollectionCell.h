//
//  YJTableCollectionCell.h
//  全球向导
//
//  Created by SYJ on 2017/4/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImgBtnClickDelegte <NSObject>
@optional
- (void)index:(NSInteger)index;

@end

@interface YJTableCollectionCell : UITableViewCell

@property (nonatomic,weak) id<ImgBtnClickDelegte> delegate;

@property (nonatomic, strong) UICollectionView *collection;


@property (nonatomic, assign) BOOL isGuide;
@property (nonatomic, assign) BOOL isSignIn;


@end
