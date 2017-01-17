//
//  YJSelcetBtn.m
//  全球向导
//
//  Created by SYJ on 2016/12/16.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSelcetBtn.h"

@implementation YJSelcetBtn

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = contentRect.size.height + 5;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - contentRect.size.height;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageX = CGRectGetMinX(contentRect);
    CGFloat imageY = CGRectGetMinY(contentRect);
    CGFloat imageW = contentRect.size.height;
    CGFloat imageH = imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}


@end
