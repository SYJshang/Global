//
//  YJGuideCollectionCell.m
//  全球向导
//
//  Created by SYJ on 2016/10/27.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGuideCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation YJGuideCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.contentView.layer.borderWidth = 2;
        
        self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"horse"]];
        [self.contentView addSubview:self.imgV];
        self.imgV.contentMode = UIViewContentModeScaleAspectFill;
        self.imgV.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,40);
        
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"portrait"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5).heightIs(45 * KWidth_Scale).widthIs(45 * KWidth_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.height / 2;
        self.icon.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.icon.layer.borderWidth = 1.0;
        
        
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.sd_layout.leftSpaceToView(self.icon,2).topSpaceToView(self.imgV,10).heightIs(15).widthIs(60 * KWidth_Scale);
        self.name.text = @"By 李默凡";
        self.name.textColor = [UIColor blackColor];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        
        
        self.positionLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.positionLab];
        self.positionLab.sd_layout.rightSpaceToView(self.contentView,2).topSpaceToView(self.imgV,10).heightIs(15).leftSpaceToView(self.name,0);
        self.positionLab.text = @"伦敦向导";
        self.positionLab.textColor = [UIColor grayColor];
        self.positionLab.textAlignment = NSTextAlignmentCenter;
        self.positionLab.font = [UIFont systemFontOfSize:AdaptedWidth(12)];

        
        
    }
    
    return self;
}

- (void)setGuideModel:(YJGuideModel *)guideModel{
    
    _guideModel = guideModel;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:guideModel.coverPhotoUrl] placeholderImage:[UIImage imageNamed:@"horse"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:guideModel.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.name.text = [NSString stringWithFormat:@"by %@",guideModel.realName];
    NSString *type;

    if ([guideModel.type isEqualToString:@"1"]) {
        type = @"导游";
    }else if ([guideModel.type isEqualToString:@"2"]){
        
        type = @"地导";

    }else if ([guideModel.type isEqualToString:@"3"]){
        type = @"景区导游";
        
    }else if ([guideModel.type isEqualToString:@"4"]){
        
        type = @"导购达人";
    }else if ([guideModel.type isEqualToString:@"5"]){
        type = @"游学";
        
    }else if ([guideModel.type isEqualToString:@"6"]){
        type = @"其他";
        
    }
    self.positionLab.text = [NSString stringWithFormat:@"|%@|",type];

    
}

@end
