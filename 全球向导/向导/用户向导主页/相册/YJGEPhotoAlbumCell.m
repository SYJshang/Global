//
//  YJPhotoAlbumCell.m
//  全球向导
//
//  Created by SYJ on 2017/2/28.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGEPhotoAlbumCell.h"

@implementation YJGEPhotoAlbumCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.line = [[UIImageView alloc]init];
        self.line.image = [UIImage imageNamed:@"inclined"];
        self.line.contentMode = UIViewContentModeRedraw;
        [self.contentView addSubview:self.line];

        self.line.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,20);
        
        self.imgIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgIcon];
        self.imgIcon.layer.masksToBounds = YES;
        self.imgIcon.layer.cornerRadius = 5.0;
        self.imgIcon.contentMode = UIViewContentModeScaleAspectFill;
        //        self.imgIcon.contentMode=UIViewContentModeScaleAspectFit;
        self.imgIcon.sd_layout.leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,25);
        
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).topSpaceToView(self.line,0).heightIs(20);
        label.text = @"这是一个相册的名称";
        self.text = label;
        
        
    }
    
    return self;
}


@end
