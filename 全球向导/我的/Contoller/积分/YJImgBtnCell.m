
//
//  YJImgBtnCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJImgBtnCell.h"

#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 3)

@implementation YJImgBtnCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.img = [[UIImageView alloc]init];
        [self addSubview:self.img];
        self.img.sd_layout.topSpaceToView(self,Kwidths * 0.2).centerXEqualToView(self).widthIs(Kwidths * 0.4).heightIs(Kwidths * 0.4);
        self.img.userInteractionEnabled = YES;
        
        self.name = [[UILabel alloc]init];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.name.textColor = [UIColor lightGrayColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
        self.name.sd_layout.centerXEqualToView(self).topSpaceToView(self.img, 5).heightIs(Kwidths * 0.2).widthIs(Kwidths);
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
        self.layer.borderColor = BackGroundColor.CGColor;
        self.layer.borderWidth = 0.5;

    }
    
    return self;
    
}

@end
