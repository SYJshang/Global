//
//  YJDrawbackCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDrawbackCell.h"

@implementation YJDrawbackCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //订单
        self.orderLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.orderLab];
        self.orderLab.font= [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.orderLab.textColor=[UIColor blackColor];
        self.orderLab.text = @"订单号 12345678900";
        self.orderLab.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,5).widthIs(150.0).heightIs(20 * KHeight_Scale);
        
        //状态
        self.stateLab = [[UILabel alloc]init];
        self.stateLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.stateLab.textColor=[UIColor blackColor];
        self.stateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.stateLab];
        self.stateLab.sd_layout.rightSpaceToView(self.contentView,10).topEqualToView(self.orderLab).widthIs(100.0).bottomEqualToView(self.orderLab);
        
        //中间线
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = BackGroundColor;
        line.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(1).topSpaceToView(self.orderLab,5);
        
        //头像
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nearby"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(line,5).widthIs(90 * KWidth_Scale).heightIs(90 * KWidth_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.width / 2;
        self.icon.layer.borderColor = BackGroundColor.CGColor;
        self.icon.layer.borderWidth = 1.0;
        
        //名称
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14.0)];
        self.nameLab.text = @"黄大粗";
        self.nameLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(line,30 * KHeight_Scale).widthIs(80).heightIs(20 *KHeight_Scale);
        
        //描述
        self.descLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.descLab];
        self.descLab.textColor = [UIColor grayColor];
        self.descLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.descLab.text = @"流淌在心里的血液啊~~";
        self.descLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.nameLab,0).widthIs(150 *KWidth_Scale).heightIs(20 *KHeight_Scale);
        
        //描述
        self.priceLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.priceLab];
        self.priceLab.textColor = [UIColor blackColor];
        self.priceLab.textAlignment = NSTextAlignmentRight;
        self.priceLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.priceLab.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.descLab).leftSpaceToView(self.descLab,5).heightEqualToWidth(self.descLab);
        
        //中间线
        UIView *line1 = [[UIView alloc]init];
        [self.contentView addSubview:line1];
        line1.backgroundColor = BackGroundColor;
        line1.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(1).topSpaceToView(self.icon,5);
        
        
        //退款金额
        self.refundPrice = [[UILabel alloc]init];;
        [self.contentView addSubview:self.refundPrice];
        self.refundPrice.textAlignment = NSTextAlignmentRight;
        self.refundPrice.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.refundPrice.textColor = [UIColor grayColor];
        self.refundPrice.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(line1,5).heightIs(30 * KHeight_Scale).widthIs(130 *KWidth_Scale);
        
        
        

        
        
        //交易
        self.Allprice = [[UILabel alloc]init];;
        [self.contentView addSubview:self.Allprice];
//        self.Allprice.textAlignment = NSTextAlignmentRight;
        self.Allprice.text = @"交易金额:￥30000";
        self.Allprice.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.Allprice.textColor = [UIColor grayColor];
        self.Allprice.sd_layout.rightSpaceToView(self.refundPrice,5).topSpaceToView(line1,5).heightIs(30 * KHeight_Scale).widthIs(130 *KWidth_Scale);

        
        
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        view.backgroundColor = BackGray;
        view.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.refundPrice,5).bottomSpaceToView(self.contentView,0);
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
    
}

- (void)setModel:(YJBuyListModel *)model{
    
    
    _model = model;
    
    self.orderLab.text = [NSString stringWithFormat:@"订单号 %@",model.orderNo];
//    NSString *status = [NSString stringWithFormat:@"%@",];
    self.stateLab.text = self.refundStatusMap[model.status];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.showPicUrl]] placeholderImage:[UIImage imageNamed:@"head"]];
    self.nameLab.text = model.bigTitle;
    self.descLab.text = model.smallTitle;
    
    NSString *text = model.tradeMoney;
    NSString *priceText = [NSString stringWithFormat:@"合计 ￥%@",text];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(14.0)]
     
                          range:NSMakeRange(4, text.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(4, text.length)];
    
    self.priceLab.attributedText = AttributedStr;
    
    
    
    NSString *priceText1 = [NSString stringWithFormat:@"合计  ￥%@",model.tradeMoney];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:priceText1];
    
    [AttributedStr1 addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(14.0)]
     
                          range:NSMakeRange(5, model.tradeMoney.length)];
    
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(5, model.tradeMoney.length)];
    
    self.priceLab.attributedText = AttributedStr1;
    
    
    
    NSString *priceText2 = [NSString stringWithFormat:@"退款金额:%@",model.refundMoney];
    NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:priceText2];
    
    [AttributedStr2 addAttribute:NSFontAttributeName
     
                           value:[UIFont systemFontOfSize:AdaptedWidth(14.0)]
     
                           range:NSMakeRange(5, model.refundMoney.length)];
    
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName
     
                           value:TextColor
     
                           range:NSMakeRange(5, model.refundMoney.length)];
    
    self.refundPrice.attributedText = AttributedStr2;
    
    
    self.Allprice.text = [NSString stringWithFormat:@"交易金额:￥%@",model.tradeMoney];
    


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
