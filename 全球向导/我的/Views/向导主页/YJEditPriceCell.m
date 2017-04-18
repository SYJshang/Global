//
//  YJEditPriceCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/13.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJEditPriceCell.h"

@implementation YJEditPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [[UILabel alloc]init];
        self.name.text = @"人数";
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.name];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.name.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(80);
        
        
        self.price = [[UITextField alloc]init];
//        self.price.text = @"￥98.00";
        self.price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.price];
        self.price.textColor = [UIColor grayColor];
        self.price.placeholder = @"请输入价格";
        self.price.keyboardType = UIKeyboardTypeNumberPad;
        self.price.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.price.sd_layout.leftSpaceToView(self.name,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10);
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGroundColor;
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
