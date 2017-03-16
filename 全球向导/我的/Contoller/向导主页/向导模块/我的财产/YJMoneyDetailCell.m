//
//  YJMoneyDetailCell.m
//  全球向导
//
//  Created by SYJ on 2017/3/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMoneyDetailCell.h"

@implementation YJMoneyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.MoneyType = [[UILabel alloc]init];
        [self.contentView addSubview:self.MoneyType];
        self.MoneyType.textColor = [UIColor blackColor];
        self.MoneyType.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.MoneyType.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).widthIs(100).heightRatioToView(self.contentView, 0.5);
        
        self.time = [[UILabel alloc]init];
        [self.contentView addSubview:self.time];
        self.time.textColor = [UIColor lightGrayColor];
        self.time.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.time.textAlignment = NSTextAlignmentRight;
        self.time.sd_layout.leftSpaceToView(self.MoneyType, 10).rightSpaceToView(self.contentView, 10).centerYEqualToView(self.MoneyType).heightRatioToView(self.contentView, 0.5);
        
        self.yuE = [[UILabel alloc]init];
        [self.contentView addSubview:self.yuE];
        self.yuE.textColor = [UIColor blackColor];
        self.yuE.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.yuE.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.MoneyType, 0).widthIs(100).heightRatioToView(self.contentView, 0.5);
        
        self.money = [[UILabel alloc]init];
        [self.contentView addSubview:self.money];
        self.money.textColor = [UIColor blackColor];
        self.money.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
        self.money.textAlignment = NSTextAlignmentRight;
        self.money.sd_layout.leftSpaceToView(self.MoneyType, 10).rightSpaceToView(self.contentView, 10).centerYEqualToView(self.yuE).heightRatioToView(self.contentView, 0.49);
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topSpaceToView(self.money, 0).heightIs(1.0);
        line.backgroundColor = BackGray;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    return self;
    
}

-(void)setModel:(YJMoneyDetailModel *)model{
    
    _model = model;
    
    self.MoneyType.text = self.typeMap[model.type];
    self.time.text = model.addTime;
    self.yuE.text = [NSString stringWithFormat:@"余额:%@",model.useMoney];
    if (model.flow == 1) {
        self.money.text = [NSString stringWithFormat:@"+ %@",model.money];
 
    }else{
        self.money.text = [NSString stringWithFormat:@"- %@",model.money];

    }
    
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
