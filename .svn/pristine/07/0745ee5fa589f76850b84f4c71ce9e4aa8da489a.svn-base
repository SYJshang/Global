//
//  YJScreentimeCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJScreentimeCell.h"

@implementation YJScreentimeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.tiemBord = [[UIView alloc]init];
        self.tiemBord.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tiemBord];
        self.tiemBord.layer.masksToBounds = YES;
        self.tiemBord.layer.cornerRadius = 3;
        self.tiemBord.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.tiemBord.layer.borderWidth = 1.0;
        self.tiemBord.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,8).bottomSpaceToView(self.contentView,8).widthIs(130 * KWidth_Scale);
        
        self.tiem = [[UILabel alloc]init];
        self.tiem.textColor = [UIColor grayColor];
        [self.tiemBord addSubview:self.tiem];
        self.tiem.text = @"请选择日期";
        self.tiem.textAlignment = NSTextAlignmentCenter;
        self.tiem.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.tiem.sd_layout.leftSpaceToView(self.tiemBord,5).topSpaceToView(self.tiemBord,5).bottomSpaceToView(self.tiemBord,5).widthIs(100 * KWidth_Scale);
        
        
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my-publish"]];
        [self.tiemBord addSubview:self.img];
        self.img.sd_layout.centerYEqualToView(self.tiem).leftSpaceToView(self.tiem,5).widthIs(15).heightIs(15);
        
        
        
        self.backgroundColor = BackGray;
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
