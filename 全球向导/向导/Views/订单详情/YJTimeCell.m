//
//  YJTimeCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTimeCell.h"
#import "SDAutoLayout.h"

@implementation YJTimeCell


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
        self.img.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.contentView).heightIs(16).widthIs(8);
        
        self.time = [[UILabel alloc]init];
        self.time.textColor = [UIColor lightGrayColor];
        self.time.text = @"请选择日期";
        self.time.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.time];
        self.time.sd_layout.leftSpaceToView(self.title,5).rightSpaceToView(self.img,8).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10);
        
        
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
