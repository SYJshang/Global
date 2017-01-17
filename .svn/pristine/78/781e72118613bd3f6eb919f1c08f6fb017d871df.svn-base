//
//  YJSubmitCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSubmitCell.h"
#import "SDAutoLayout.h"

@implementation YJSubmitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.priceAll = [[UILabel alloc]init];
        self.priceAll.textColor = TextColor;
        self.priceAll.backgroundColor = [UIColor whiteColor];
        self.priceAll.text = @"合计 ￥100";
        [self.contentView addSubview:self.priceAll];
        self.priceAll.textAlignment = NSTextAlignmentCenter;
        self.priceAll.font = [UIFont systemFontOfSize:17.0];
        self.priceAll.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).widthIs(screen_width / 2 - 10);
        self.priceAll.layer.masksToBounds = YES;
        self.priceAll.layer.cornerRadius = 2;
        self.priceAll.layer.borderColor = BackGray.CGColor;
        self.priceAll.layer.borderWidth = 1;
        
        
        
        self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [self.contentView addSubview:self.submitBtn];
        [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submitBtn.backgroundColor = TextColor;
        [self.submitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.submitBtn.sd_layout.leftSpaceToView(self.priceAll,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
        self.submitBtn.layer.masksToBounds = YES;
        self.submitBtn.layer.cornerRadius = 2;
        self.submitBtn.layer.borderColor = [UIColor colorWithRed:255.0 / 255.0 green:230.0 / 255.0 blue:130.0 / 255.0 alpha:1.0].CGColor;
        self.submitBtn.layer.borderWidth = 1;
        
    }
    
    return self;
}

- (void)click:(UIButton *)sender{
    
    NSLog(@"提交订单");
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
