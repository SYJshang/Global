//
//  YJRelateDayCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/19.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJRelateDayCell.h"

@implementation YJRelateDayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.num = [[UILabel alloc]init];
        self.num.text = @"人数";
        self.num.textColor = [UIColor blackColor];
        self.num.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.contentView addSubview:self.num];
        self.num.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(70.0);
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.addBtn];
        [self.addBtn setImage:[UIImage imageNamed:@"adds"] forState:UIControlStateNormal];
        [self.addBtn setImage:[UIImage imageNamed:@"add1"] forState:UIControlStateHighlighted];
        self.addBtn.tag = 100;
        [self.addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(20.0);
        
        self.numLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.numLab];
        self.numLab.text = @"0";
        self.numLab.textAlignment = NSTextAlignmentCenter;
        self.numLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.numLab.textColor = [UIColor blackColor];
        self.numLab.sd_layout.rightSpaceToView(self.addBtn,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(40.0);
        
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.reduceBtn];
        [self.reduceBtn setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
        [self.reduceBtn setImage:[UIImage imageNamed:@"reduce1"] forState:UIControlStateHighlighted];
        self.reduceBtn.tag = 101;
        [self.reduceBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.reduceBtn.sd_layout.rightSpaceToView(self.numLab,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(20.0);
        
        self.descLab = [[UILabel alloc]init];
        self.descLab.text = @"人数";
        self.descLab.textAlignment = NSTextAlignmentLeft;
        self.descLab.textColor = [UIColor grayColor];
        self.descLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.contentView addSubview:self.descLab];
        self.descLab.sd_layout.leftSpaceToView(self.num,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).rightSpaceToView(self.reduceBtn,5);

        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGroundColor;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        
        self.people = 0;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}


- (void)addBtn:(UIButton *)sender{
    
    [self.delegate btnClick:self andFlag:(int)sender.tag];
    
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
