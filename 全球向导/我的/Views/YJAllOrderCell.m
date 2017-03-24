//
//  YJAllOrderCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAllOrderCell.h"

@implementation YJAllOrderCell

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
//        if (self.orderState == 1) {
//            self.stateLab.text = @"待评价";
//        }else if (self.orderState == 2){
//            self.stateLab.text = @"交易成功";
//        }else if (self.orderState == 3){
//            self.stateLab.text = @"已完成";
//        }else if (self.orderState == 4){
//            self.stateLab.text = @"退款中";
//        }else{
//            self.stateLab.text = @"待购买";
//        }
        self.stateLab.sd_layout.rightSpaceToView(self.contentView,10).topEqualToView(self.orderLab).widthIs(100.0).bottomEqualToView(self.orderLab);
        
    //中间线
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGray;
    line.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(1).topSpaceToView(self.orderLab,5);
    
    //头像
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nearby"]];
    [self.contentView addSubview:self.icon];
    self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(line,5).widthIs(90 * KWidth_Scale).heightIs(90 * KWidth_Scale);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width / 2;
    self.icon.layer.borderColor = BackGray.CGColor;
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
    line1.backgroundColor = BackGray;
    line1.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(1).topSpaceToView(self.icon,5);
        
        
    //付款按钮
    self.buyOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.buyOrder];
    [self.buyOrder setTitle:@"付款" forState:UIControlStateNormal];
    self.buyOrder.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    [self.buyOrder setTitleColor:TextColor forState:UIControlStateNormal];
    [self.buyOrder setBackgroundColor:[UIColor whiteColor]];
    [self.buyOrder addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.buyOrder.tag = 1;
    self.buyOrder.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(line1,5).heightIs(30 * KHeight_Scale).widthIs(80 *KWidth_Scale);
    self.buyOrder.layer.masksToBounds = YES;
    self.buyOrder.layer.cornerRadius = 13.0;
    self.buyOrder.layer.borderColor = TextColor.CGColor;
    self.buyOrder.layer.borderWidth = 1.0;

    
    //联系向导
    self.relation = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.relation];
    [self.relation setTitle:@"联系向导" forState:UIControlStateNormal];
    [self.relation setTitleColor:TextColor forState:UIControlStateNormal];
    [self.relation setBackgroundColor:[UIColor whiteColor]];
    [self.relation addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.relation.tag = 2;
    self.relation.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.relation.sd_layout.rightSpaceToView(self.buyOrder,5).topSpaceToView(line1,5).heightIs(30 * KHeight_Scale).widthIs(80 *KWidth_Scale);
    self.relation.layer.masksToBounds = YES;
    self.relation.layer.cornerRadius = 13;
    self.relation.layer.borderColor = TextColor.CGColor;
    self.relation.layer.borderWidth = 1.0;
    
    
    //取消订单
    self.disOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.disOrder];
    [self.disOrder setTitle:@"取消订单" forState:UIControlStateNormal];
    self.disOrder.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    [self.disOrder setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.disOrder setBackgroundColor:[UIColor whiteColor]];
    [self.disOrder addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.disOrder.tag = 3;
    self.disOrder.sd_layout.rightSpaceToView(self.relation,5).topSpaceToView(line1,5).heightIs(30 * KHeight_Scale).widthIs(80 *KWidth_Scale);
    self.disOrder.layer.masksToBounds = YES;
    self.disOrder.layer.cornerRadius = 13;
    self.disOrder.layer.borderColor = BackGray.CGColor;
    self.disOrder.layer.borderWidth = 1.0;

    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    view.backgroundColor = BackGray;
    view.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.buyOrder,5).bottomSpaceToView(self.contentView,0);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    return self;
    
}

- (void)action:(UIButton *)btn{
    
//    NSInteger tap = btn.tag;
    //通知代理
    if ([self.delegate respondsToSelector:@selector(btnDidClickPlusButton:)]) {
        [self.delegate btnDidClickPlusButton:btn];
    }

    
}


- (void)setModel:(YJOrderListModel *)model{
    
    _model = model;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *orderStatus = [defaults objectForKey:@"orderStatus"];
    
    self.orderLab.text = [NSString stringWithFormat:@"订单号 %@",model.orderNo];
    NSString *status = [NSString stringWithFormat:@"%ld",model.status];
    self.stateLab.text = orderStatus[status];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.showPicUrl]] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
    self.nameLab.text = model.bigTitle;
    self.descLab.text = model.smallTitle;
    
    NSString *text = model.totalMoney;
    NSString *priceText = [NSString stringWithFormat:@"合计 ￥%@",text];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(14.0)]
     
                          range:NSMakeRange(4, text.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(4, text.length)];
    
    self.priceLab.attributedText = AttributedStr;

    

    
    switch (model.status) {
        case 1:
            self.disOrder.hidden = NO;
            self.relation.hidden = NO;
            self.buyOrder.hidden = NO;
            [self.disOrder setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.relation setTitle:@"立即付款" forState:UIControlStateNormal];
            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];

            break;
        case 2:
            self.disOrder.hidden = NO;
            self.relation.hidden = NO;
            self.buyOrder.hidden = NO;
            [self.disOrder setTitle:@"确认交易" forState:UIControlStateNormal];
            [self.relation setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];
            break;
        case 3:
            
            if (model.isFinishEva == 0) {
                self.disOrder.hidden = YES;
                self.relation.hidden = NO;
                self.buyOrder.hidden = NO;
                
                [self.relation setTitle:@"去评价" forState:UIControlStateNormal];
                [self.buyOrder setTitle:@"再次预定" forState:UIControlStateNormal];
            }else{
                self.disOrder.hidden = YES;
                self.relation.hidden = YES;
                self.buyOrder.hidden = NO;
                [self.buyOrder setTitle:@"再次预定" forState:UIControlStateNormal];
            }
           
            break;
        case 4:
            self.relation.hidden = NO;
            self.buyOrder.hidden = NO;

            self.disOrder.hidden = YES;
            [self.relation setTitle:@"退款中" forState:UIControlStateNormal];
            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];
            break;
        case 5:
            self.disOrder.hidden = YES;
            self.relation.hidden = NO;
            self.buyOrder.hidden = NO;

            [self.relation setTitle:@"退款中" forState:UIControlStateNormal];
            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];
            break;
        case 6:
            self.disOrder.hidden = YES;
            self.relation.hidden = YES;

            self.buyOrder.hidden = NO;

            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];
            break;
        case 7:
            self.disOrder.hidden = YES;
            self.relation.hidden = NO;
            self.buyOrder.hidden = NO;
            [self.relation setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.buyOrder setTitle:@"联系向导" forState:UIControlStateNormal];            break;
            
        default:
            break;
    }
    
    
}


- (void)setEvaModel:(YJEvaWaitModel *)evaModel{
    
    _evaModel = evaModel;
    
    self.orderLab.text = [NSString stringWithFormat:@"订单号 %@",evaModel.orderNo];
//    NSString *status = [NSString stringWithFormat:@"%ld",evaModel.status];
    
    if (self.orderState == 1) {
        self.stateLab.text = @"待评价";
        self.disOrder.hidden = YES;
        self.relation.hidden = NO;
        self.buyOrder.hidden = NO;
        
        [self.buyOrder setTitle:@"评价" forState:UIControlStateNormal];
        [self.relation setTitle:@"再次预定" forState:UIControlStateNormal];

    }else{
        self.stateLab.text = @"已评价";
        
        self.disOrder.hidden = YES;
        self.relation.hidden = YES;
        self.buyOrder.hidden = NO;
        [self.buyOrder setTitle:@"再次预定" forState:UIControlStateNormal];
    }
    
    
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",evaModel.showPicUrl]] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
    self.nameLab.text = evaModel.bigTitle;
    self.descLab.text = evaModel.smallTitle;
    
    NSString *text = evaModel.price;
    NSString *priceText = [NSString stringWithFormat:@"合计 ￥%@",text];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(14.0)]
     
                          range:NSMakeRange(4, text.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:TextColor
     
                          range:NSMakeRange(4, text.length)];
    
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
