//
//  YJAddNumCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAddNumCell.h"

@implementation YJAddNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.num = [[UILabel alloc]init];
        self.num.text = @"人数";
        self.num.textColor = [UIColor blackColor];
        self.num.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.contentView addSubview:self.num];
        self.num.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(100.0);
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.addBtn];
        [self.addBtn setImage:[UIImage imageNamed:@"adds"] forState:UIControlStateNormal];
        [self.addBtn setImage:[UIImage imageNamed:@"add1"] forState:UIControlStateHighlighted];
        [self.addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(20.0);
        
        self.numLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.numLab];
        self.numLab.text = @"1";
        self.numLab.textAlignment = NSTextAlignmentCenter;
        self.numLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.numLab.textColor = [UIColor blackColor];
        self.numLab.sd_layout.rightSpaceToView(self.addBtn,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(40.0);
        
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.reduceBtn];
        [self.reduceBtn setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
        [self.reduceBtn setImage:[UIImage imageNamed:@"reduce1"] forState:UIControlStateHighlighted];
        [self.reduceBtn addTarget:self action:@selector(reduceBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.reduceBtn.sd_layout.rightSpaceToView(self.numLab,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(20.0);
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGroundColor;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        
        self.people = 1;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}


- (void)addBtn:(UIButton *)sender{
    
    XXLog(@"sssssss");
    
    if (self.peoBlock) {
        self.peoBlock();
    }
    
}


- (void)reduceBtn:(UIButton *)sender{
    
    if (self.peoReduBlock) {
        self.peoReduBlock();
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
