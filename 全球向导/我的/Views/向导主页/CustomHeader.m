//
//  CustomHeader.m
//  ARSegmentPager
//
//  Created by August on 15/5/20.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "CustomHeader.h"

@interface CustomHeader ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@end

@implementation CustomHeader

-(void)awakeFromNib
{

}

- (UIImageView *)backgroundImageView {
    return self.imageView;
}

- (void)updateHeadPhotoWithTopInset:(CGFloat)inset {
    CGFloat ratio =  (inset - 64) / 200.0;
    self.bottomConstraint.constant = ratio * 50 + 10;
    self.widthConstraint.constant = 30 + ratio * 70;
    self.nameLab.font = [UIFont systemFontOfSize:24 * ratio];
//    self.bottomCOnstraint.constant = 30 + ratio * 50;
    
    
}

@end
