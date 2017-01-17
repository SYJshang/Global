
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
        NSString *text = @"100";
        NSString *priceText = [NSString stringWithFormat:@"总计 ￥%@",text];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
        
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:18.0]
         
                              range:NSMakeRange(4, text.length)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:TextColor
         
                              range:NSMakeRange(4, text.length)];
        

        self.allPrice.attributedText = AttributedStr;
        [self.contentView addSubview:self.allPrice];
        self.allPrice.sd_layout.rightSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,100).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10);
        
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
