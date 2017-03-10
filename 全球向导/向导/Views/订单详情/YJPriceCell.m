
//
//  YJPriceCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPriceCell.h"

@implementation YJPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.allPrice = [[UILabel alloc]init];
        self.allPrice.textAlignment = NSTextAlignmentRight;
        self.allPrice.font = [UIFont systemFontOfSize:15.0];
//        self.text = @"100";

        [self.contentView addSubview:self.allPrice];
        self.allPrice.sd_layout.rightSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,100).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}


- (void)setModel:(YJOrderFinshModel *)model{
    
    _model = model;
   
//    NSString *price = model.totalMoney;
    
    NSString *priceText = [NSString stringWithFormat:@"总计 ￥%@",model.totalMoney];
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(18.0)]
     
                          range:NSMakeRange(4, model.totalMoney.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(4, model.totalMoney.length)];
    
    
    self.allPrice.attributedText = AttributedStr;

    
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
