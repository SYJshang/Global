
//
//  YJOtherServerCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJOtherServerCell.h"

@implementation YJOtherServerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}

- (void)initView{
    
    self.imgIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon1"]];
    [self.contentView addSubview:self.imgIcon];
    self.imgIcon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthEqualToHeight();
    
    self.titelLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.titelLab];
    self.titelLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.titelLab.textColor = [UIColor blackColor];
    self.titelLab.sd_layout.leftSpaceToView(self.imgIcon,5).centerYEqualToView(self.imgIcon).heightIs(15).widthIs(150);
    
    self.priceLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.priceLab];
    self.priceLab.textColor = [UIColor blueColor];
    self.priceLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.priceLab.text = @"￥98.00起";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.sd_layout.rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).heightIs(20 * KHeight_Scale).widthIs(80 * KWidth_Scale);
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
    
    [AttributedStr addAttributes:@{NSFontAttributeName:
                                       [UIFont systemFontOfSize:AdaptedWidth(12)],
                                   NSForegroundColorAttributeName:BackGroundColor}
     
                           range:NSMakeRange(self.priceLab.text.length - 1, 1)];
    
    
    self.priceLab.attributedText = AttributedStr;
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0.5).heightIs(0.5);

    
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
