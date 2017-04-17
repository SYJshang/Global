
//
//  YJIntrgralDetailCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJIntrgralDetailCell.h"

@implementation YJIntrgralDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        self.intrLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.intrLab];
        self.intrLab.textColor = [UIColor blackColor];
        self.intrLab.textAlignment = NSTextAlignmentCenter;
        self.intrLab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(13)];
        self.intrLab.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 10).widthIs(80).heightIs(40);
        self.intrLab.text = @"+10000";
        self.intrLab.layer.masksToBounds = YES;
        self.intrLab.layer.cornerRadius = 1;
        self.intrLab.layer.borderColor = BackGray.CGColor;
        self.intrLab.layer.borderWidth = 0.5;
        
        
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        view.sd_layout.leftSpaceToView(self.intrLab,0).rightSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(40);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.layer.borderColor = BackGray.CGColor;
        view.layer.borderWidth = 0.5;

        self.orderNo = [[UILabel alloc]init];
        [view addSubview:self.orderNo];
        self.orderNo.textColor = [UIColor lightGrayColor];
        self.orderNo.text = @"完成一笔订单（订单号12345678）";
        self.orderNo.textAlignment = NSTextAlignmentLeft;
        self.orderNo.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.orderNo.sd_layout.topSpaceToView(view, 0).leftSpaceToView(view, 5).rightSpaceToView(view, 0).heightIs(20);
     
        self.timeLab = [[UILabel alloc]init];
        [view addSubview:self.timeLab];
        self.timeLab.text = @"2017-4-17";
        self.timeLab.textColor = [UIColor lightGrayColor];
        self.timeLab.textAlignment = NSTextAlignmentLeft;
        self.timeLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.timeLab.sd_layout.topSpaceToView(self.orderNo,0).leftSpaceToView(view, 5).rightSpaceToView(view, 0).heightIs(20);
        
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
