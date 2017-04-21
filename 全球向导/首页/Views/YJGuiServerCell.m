
//
//  YJGuiServerCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGuiServerCell.h"
#import "UIImageView+WebCache.h"

@implementation YJGuiServerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = BackGray;

        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void)initView{
    
    self.imgIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon3"]];
    [self.contentView addSubview:self.imgIcon];
    self.imgIcon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).heightIs(50).widthIs(50);
    self.imgIcon.layer.masksToBounds = YES;
    self.imgIcon.layer.cornerRadius = self.imgIcon.width /2;
    self.imgIcon.layer.borderWidth = 0.5;
    self.imgIcon.layer.borderColor = BackGroundColor.CGColor;
    
    self.titleLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLab];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
    self.titleLab.sd_layout.leftSpaceToView(self.imgIcon,5).topSpaceToView(self.contentView,(self.imgIcon.centerY - 8) * KHeight_Scale).widthIs(100 * KWidth_Scale).heightIs(20 * KHeight_Scale);
    
    self.descLab = [[UILabel alloc]init];
    self.descLab.textColor = [UIColor grayColor];
    self.descLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    [self.contentView addSubview:self.descLab];
    self.descLab.sd_layout.leftEqualToView(self.titleLab).topSpaceToView(self.titleLab,5).heightIs(20 * KHeight_Scale).widthIs(130 * KWidth_Scale);
    
    self.priceLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.priceLab];
    self.priceLab.textColor = [UIColor colorWithRed:35.0 / 255.0 green:125.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    self.priceLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.priceLab.text = @"￥98.00起";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.descLab).heightIs(20 * KHeight_Scale).widthIs(80 * KWidth_Scale);
   
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];

    
    [AttributedStr addAttributes:@{NSFontAttributeName:
                                    [UIFont systemFontOfSize:AdaptedWidth(12)],
                                   NSForegroundColorAttributeName:[UIColor lightGrayColor]}
                                   
                                    range:NSMakeRange(self.priceLab.text.length - 1, 1)];
    
    
    self.priceLab.attributedText = AttributedStr;
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0.5).heightIs(0.5);
    
}

- (void)setModel:(YJServerModel *)model{
    
    _model = model;
    self.titleLab.text = model.name;
    self.descLab.text = model.desc;
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"icon3"]];
    self.priceLab.text = [NSString stringWithFormat:@"￥%@起",model.price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
    
    
    [AttributedStr addAttributes:@{NSFontAttributeName:
                                       [UIFont systemFontOfSize:AdaptedWidth(12)],
                                   NSForegroundColorAttributeName:[UIColor lightGrayColor]}
     
                           range:NSMakeRange(self.priceLab.text.length - 1, 1)];
    
    
    self.priceLab.attributedText = AttributedStr;

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
