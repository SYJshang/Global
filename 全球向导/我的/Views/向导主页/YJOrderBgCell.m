//
//  YJOrderBgCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOrderBgCell.h"

@implementation YJOrderBgCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //订单号
        self.orderNum = [[UILabel alloc]init];
        self.orderNum.textColor = [UIColor grayColor];
        self.orderNum.text = @"订单号 123456789";
        self.orderNum.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        [self.contentView addSubview:self.orderNum];
        self.orderNum.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,5).heightIs(15 * KHeight_Scale).widthIs(130 * KWidth_Scale);
        
        //状态
        self.stateLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.stateLab];
        self.stateLab.text = @"待接单";
        self.stateLab.textColor = [UIColor blackColor];
        self.stateLab.textAlignment = NSTextAlignmentRight;
        self.stateLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.stateLab.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,5).widthIs(60 * KWidth_Scale).heightIs(15);
        
        //时间
        self.timeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLab];
        self.timeLab.hidden = YES;
        self.timeLab.text = @"12:00:00";
        self.timeLab.font = [UIFont systemFontOfSize:AdaptedWidth(12.0)];
        self.timeLab.textColor = [UIColor grayColor];
        self.timeLab.textAlignment = NSTextAlignmentLeft;
        self.timeLab.sd_layout.rightSpaceToView(self.stateLab,5).topSpaceToView(self.contentView,5).heightIs(15 * KHeight_Scale).widthIs(70 * KWidth_Scale);
        
        //时间icon
        self.timeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"daojishi"]];
        [self.contentView addSubview:self.timeIcon];
        self.timeIcon.hidden = YES;
        self.timeIcon.sd_layout.rightSpaceToView(self.timeLab,2).centerYEqualToView(self.timeLab).heightIs(12 * KHeight_Scale).widthIs(14 * KHeight_Scale);
        
        //分割线
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.timeLab,5 * KHeight_Scale).rightEqualToView(self.contentView).heightIs(1);
        line.backgroundColor = BackGray;
        
        //预订人名称
        //icon
        self.reserveIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yudingren(1)"]];
        [self.contentView addSubview:self.reserveIcon];
        self.reserveIcon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(line,10 * KHeight_Scale).widthIs(15 * KHeight_Scale).heightIs(15 * KHeight_Scale);
        
        //名称
        self.reserveLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.reserveLab];
        self.reserveLab.textColor = [UIColor grayColor];
        self.reserveLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.reserveLab.sd_layout.leftSpaceToView(self.reserveIcon,5).centerYEqualToView(self.reserveIcon).heightIs(20 * KHeight_Scale).rightSpaceToView(self.contentView,10);
        
        
        
        //总共时长
        //icon
        self.allTimeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"miaobiao"]];
        [self.contentView addSubview:self.allTimeIcon];
        self.allTimeIcon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.reserveIcon,10 * KHeight_Scale).widthIs(15 * KHeight_Scale).heightIs(15 * KHeight_Scale);
        
        //名称
        self.allTimeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.allTimeLab];
        self.allTimeLab.textColor = [UIColor grayColor];
        self.allTimeLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.allTimeLab.sd_layout.leftSpaceToView(self.allTimeIcon,5).centerYEqualToView(self.allTimeIcon).heightIs(20 * KHeight_Scale).rightSpaceToView(self.contentView,10);
        
        
         //发现名称
         //icon
         self.findIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mingcheng"]];
         [self.contentView addSubview:self.findIcon];
         self.findIcon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.allTimeIcon,10 * KHeight_Scale).widthIs(15 * KHeight_Scale).heightIs(15 * KHeight_Scale);
         
         //名称
         self.findLab = [[UILabel alloc]init];
         [self.contentView addSubview:self.findLab];
         self.findLab.textColor = [UIColor grayColor];
         self.findLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
         self.findLab.sd_layout.leftSpaceToView(self.findIcon,5).centerYEqualToView(self.findIcon).heightIs(20 * KHeight_Scale).rightSpaceToView(self.contentView,10);
         
        
         
         
        
        
        UIView *line1 = [[UIView alloc]init];
        [self.contentView addSubview:line1];
        line1.backgroundColor = BackGray;
        line1.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topSpaceToView(self.findLab,10 * KHeight_Scale).heightIs(1);
        
        
        //接单按钮
        self.receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.receiveBtn];
        [self.receiveBtn setTitle:@"联系用户" forState:UIControlStateNormal];
        self.receiveBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.receiveBtn addTarget:self action:@selector(btnCk:) forControlEvents:UIControlEventTouchUpInside];
        self.receiveBtn.tag = 1;
        [self.receiveBtn setTitleColor:TextColor forState:UIControlStateNormal];
        [self.receiveBtn setBackgroundColor:[UIColor whiteColor]];
        self.receiveBtn.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(line1,10 * KHeight_Scale).heightIs(30 * KHeight_Scale).widthIs(80 *KWidth_Scale);
        self.receiveBtn.layer.masksToBounds = YES;
        self.receiveBtn.layer.cornerRadius = 13.0;
        self.receiveBtn.layer.borderColor = TextColor.CGColor;
        self.receiveBtn.layer.borderWidth = 1.0;
        
    
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        view.backgroundColor = BackGray;
        view.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.receiveBtn,10 * KHeight_Scale).bottomSpaceToView(self.contentView,0);
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void)btnCk:(UIButton *)btn{
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(btnClickEve:)]) {
        [self.delegate btnClickEve:btn];
    }
}


- (void)setModel:(YJGuideRefundModel *)model{
    
    _model = model;
    self.orderNum.text = [NSString stringWithFormat:@"订单号 %@",model.orderNo];
    
    NSString *status = [NSString stringWithFormat:@"%ld",model.status];
    self.stateLab.text = self.refundStatusMap[status];
    
    NSString *text1 = self.userInfoMap[model.buyerId];
    NSString *priceText1 = [NSString stringWithFormat:@"预订人名称  %@",text1];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:priceText1];
    
    [AttributedStr1 addAttribute:NSFontAttributeName
     
                           value:[UIFont boldSystemFontOfSize:AdaptedWidth(13)]
     
                           range:NSMakeRange(7, text1.length)];
    
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName
     
                           value:[UIColor blackColor]
     
                           range:NSMakeRange(7, text1.length)];
    
    self.reserveLab.attributedText = AttributedStr1;
    
    
    
    NSString *text2 = [NSString stringWithFormat:@"￥%ld",model.tradeMoney];
    NSString *priceText2 = [NSString stringWithFormat:@"总计价格     %@",text2];
    NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:priceText2];
    
    [AttributedStr2 addAttribute:NSFontAttributeName
     
                           value:[UIFont boldSystemFontOfSize:AdaptedWidth(13)]
     
                           range:NSMakeRange(9, text2.length)];
    
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName
     
                           value:[UIColor blackColor]
     
                           range:NSMakeRange(9, text2.length)];
    
    self.allTimeLab.attributedText = AttributedStr2;
    
    
    NSString *text3 = [NSString stringWithFormat:@"￥%ld",model.refundMoney];
    NSString *priceText3 = [NSString stringWithFormat:@"退款金额     %@",text3];
    NSMutableAttributedString *AttributedStr3 = [[NSMutableAttributedString alloc]initWithString:priceText3];
    
    [AttributedStr3 addAttribute:NSFontAttributeName
     
                           value:[UIFont boldSystemFontOfSize:AdaptedWidth(13)]
     
                           range:NSMakeRange(9, text3.length)];
    
    [AttributedStr3 addAttribute:NSForegroundColorAttributeName
     
                           value:TextColor
     
                           range:NSMakeRange(9, text3.length)];
    
    self.findLab.attributedText = AttributedStr3;
    
    
    
    

    
    
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
