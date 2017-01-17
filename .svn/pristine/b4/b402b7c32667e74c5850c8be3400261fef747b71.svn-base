//
//  YJPayFormCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPayFormCell.h"

@implementation YJPayFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"微信"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthEqualToHeight();
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 2;
        self.icon.layer.borderColor = BackGray.CGColor;
        self.icon.layer.borderWidth = 1;
        
        self.payName = [[UILabel alloc]init];
        self.payName.text = @"微信支付";
        self.payName.textColor = [UIColor blackColor];
        self.payName.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.contentView addSubview:self.payName];
        self.payName.sd_layout.leftSpaceToView(self.icon,5).centerYEqualToView(self.icon).heightIs(20).rightSpaceToView(self.contentView,50);
        
        
        self.access = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
        [self.contentView addSubview:self.access];
        self.access.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.contentView).heightIs(20).widthIs(13);
        
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
