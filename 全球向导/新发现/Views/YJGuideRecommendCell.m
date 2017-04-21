//
//  YJGuideRecommendCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/4.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGuideRecommendCell.h"

@implementation YJGuideRecommendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImage *abc = [UIImage imageNamed:@"big_house"];
        self.imageV = [[UIImageView alloc]initWithImage:abc];
        [self.contentView addSubview:self.imageV];
        self.imageV.sd_layout.leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = 8;
        self.imageV.layer.borderWidth = 2;
        self.imageV.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        
        self.title = [[UILabel alloc]init];
        [self.imageV addSubview:self.title];
        self.title.sd_layout.leftSpaceToView(self.imageV,20).rightSpaceToView(self.imageV,20).topSpaceToView(self.imageV,10).heightIs(30);
        self.title.text = @"让你见识到真正的月亮/从你的全世界路过";
        self.title.font = [UIFont boldSystemFontOfSize:AdaptedWidth(16.0)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor whiteColor];
        
        self.descTitle = [[UILabel alloc]init];
        [self.imageV addSubview:self.descTitle];
        self.descTitle.text = @"感谢从你的全世界路过---美好的云南之旅";
        self.descTitle.textAlignment = NSTextAlignmentCenter;
        self.descTitle.textColor = [UIColor whiteColor];
        self.descTitle.font = [UIFont systemFontOfSize:AdaptedWidth(15.0)];
        self.descTitle.sd_layout.leftEqualToView(self.title).topSpaceToView(self.title,5).heightIs(20).rightEqualToView(self.title);
        
        
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
        [self.imageV addSubview:self.icon];
        self.icon.sd_layout.leftEqualToView(self.title).bottomSpaceToView(self.imageV,5).heightIs(60 * KWidth_Scale).widthIs(60 * KWidth_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.height / 2;
        self.icon.layer.borderWidth = 2;
        self.icon.layer.borderColor =  [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
        
        self.position = [[UILabel alloc]init];
        [self.imageV addSubview:self.position];
        self.position.sd_layout.leftSpaceToView(self.icon,5 * KWidth_Scale).bottomSpaceToView(self.imageV,10).heightIs(20).widthIs(100);
        self.position.text = @"|火星向导|";
        self.position.textColor = [UIColor whiteColor];
        self.position.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        
        
        self.name = [[UILabel alloc]init];
        [self.imageV addSubview:self.name];
        self.name.sd_layout.leftSpaceToView(self.icon,5).bottomSpaceToView(self.position,2 * KWidth_Scale).heightIs(20).widthIs(100);
        self.name.text = @"by 李源";
        self.name.textColor = [UIColor whiteColor];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        
        
        self.num = [[UILabel alloc]init];
        [self.imageV addSubview:self.num];
        self.num.sd_layout.rightSpaceToView(self.imageV,10).bottomSpaceToView(self.imageV,10).heightIs(20).widthIs(150);
        self.num.text = @"浏览次数 9999";
        self.num.textColor = [UIColor whiteColor];
        self.num.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.num.textAlignment = NSTextAlignmentRight;
        
        
        self.price = [[UILabel alloc]init];
        [self.imageV addSubview:self.price];
        self.price.text = @"￥100";
        self.price.sd_layout.rightSpaceToView(self.imageV,10).bottomSpaceToView(self.num,2).heightIs(20).widthIs(150);
        self.price.textColor = [UIColor whiteColor];
        self.price.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.price.textAlignment = NSTextAlignmentRight;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setModel:(YJNFindGuideModel *)model{
    
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPicUrl] placeholderImage:[UIImage imageNamed:@"big_horse"]];
    self.title.text = model.bigTitle;
    self.descTitle.text = model.smallTitle;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.name.text = [NSString stringWithFormat:@"by %@",model.realName];
    self.position.text = [NSString stringWithFormat:@"|%@|",model.guideDesc];
    
    NSString *priceText = [NSString stringWithFormat:@"参考价格 %@元/人",model.price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange(5, model.price.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(5, model.price.length)];
    
    self.price.attributedText = AttributedStr;
    
    self.num.text = [NSString stringWithFormat:@"%@ %ld",YJLocalizedString(@"收藏"),model.colNumber];

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
