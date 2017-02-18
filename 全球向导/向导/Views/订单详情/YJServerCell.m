//
//  YJServerCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJServerCell.h"
#import "SDAutoLayout.h"

@implementation YJServerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.serverName = [[UILabel alloc]init];
        self.serverName.text = @"徒步陪同";
        self.serverName.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.serverName.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.serverName];
        self.serverName.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(70.0);
        
        
        
        
        self.serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.serverBtn setImage:[UIImage imageNamed:@"bb2"] forState:UIControlStateNormal];
        [self.serverBtn setImage:[UIImage imageNamed:@"bb1"] forState:UIControlStateSelected];
        self.serverBtn.selected = YES;
        [self.serverBtn addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.serverBtn];
        self.serverBtn.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.contentView).heightIs(15.0).widthIs(15.0);
        
//        self.price = [[UILabel alloc]init];
//        self.price.text = @"￥1000";
//        [self.contentView addSubview:self.price];
//        self.price.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
//        self.price.textColor = [UIColor blackColor];
//        self.price.textAlignment = NSTextAlignmentCenter;
//        self.price.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(50.0);
        
        
        self.price = [[UILabel alloc]init];
        self.price.text = @"徒步陪同旅游，搭乘交通工具";
        self.price.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.price.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.price];
        self.price.sd_layout.leftSpaceToView(self.serverName,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).rightSpaceToView(self.serverBtn,5);

        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGray;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    return self;
}

- (void)btnClcik:(UIButton *)sender{
    
    if (self.btnBlock) {
        self.btnBlock();
    }
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
