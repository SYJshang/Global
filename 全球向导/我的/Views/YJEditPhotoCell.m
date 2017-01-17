//
//  YJEditPhotoCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/16.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJEditPhotoCell.h"

@implementation YJEditPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.title = [[UILabel alloc]init];
        self.title.text = @"时间";
        self.title.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.title.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.title];
        self.title.sd_layout.topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(100);
        
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
        [self.contentView addSubview:self.img];
        self.img.sd_layout.rightSpaceToView(self.contentView,15).centerYEqualToView(self.contentView).heightIs(16).widthIs(8);
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg2"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.rightSpaceToView(self.img,5).centerYEqualToView(self.img).heightIs(50 * KHeight_Scale).widthIs(50 * KHeight_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = (self.icon.width * KHeight_Scale) / 2;
        self.icon.layer.borderWidth = 1.0;
        self.icon.layer.borderColor = BackGray.CGColor;
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGray;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        

    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
