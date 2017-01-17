//
//  YJDescOrderCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDescOrderCell.h"

@implementation YJDescOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [[UILabel alloc]init];
        self.name.text = @"人数";
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.name];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.name.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(80);
        
        
        self.desc = [[UILabel alloc]init];
        self.desc.text = @"10人";
        [self.contentView addSubview:self.desc];
        self.desc.textColor = [UIColor grayColor];
        self.desc.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.desc.sd_layout.leftSpaceToView(self.name,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10);
        
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
