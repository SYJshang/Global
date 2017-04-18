
//
//  YJIntegralTopCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJIntegralTopCell.h"

@implementation YJIntegralTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = TextColor;
        [self.contentView addSubview:view];
        view.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).heightIs(180);
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
        [view addSubview:self.icon];
        self.icon.sd_layout.centerYEqualToView(view).centerXEqualToView(view).widthIs(80).heightIs(80);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 40;
        self.icon.layer.borderColor = BackGroundColor.CGColor;
        self.icon.layer.borderWidth = 0.5;
        
        
        self.NoLab = [[UILabel alloc]init];
        [view addSubview:self.NoLab];
        self.NoLab.textColor = [UIColor whiteColor];
        self.NoLab.textAlignment = NSTextAlignmentCenter;
        self.NoLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.NoLab.sd_layout.topSpaceToView(self.icon, 5).centerXEqualToView(self.icon).widthIs(150).heightIs(20);
        self.NoLab.text = @"123456789";
        
        self.userInge = [[UILabel alloc]init];
        [view addSubview:self.userInge];
        self.userInge.textColor = [UIColor whiteColor];
        self.userInge.textAlignment = NSTextAlignmentCenter;
        self.userInge.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.userInge.sd_layout.bottomSpaceToView(view,-10).centerXEqualToView(self.icon).widthIs(160).heightIs(30);
        self.userInge.text = @"可用积分:1231234";
        self.userInge.layer.masksToBounds = YES;
        self.userInge.layer.cornerRadius = 12;
        self.userInge.layer.borderColor = BackGroundColor.CGColor;
        self.userInge.layer.borderWidth = 1.0;
        self.userInge.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:207 / 255.0 blue:125 / 255.0 alpha:1.0];
        
        self.pastInteg = [[UILabel alloc]init];
        [self.contentView addSubview:self.pastInteg];
        self.pastInteg.textColor = [UIColor lightGrayColor];
        self.pastInteg.textAlignment = NSTextAlignmentCenter;
        self.pastInteg.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.pastInteg.sd_layout.bottomSpaceToView(self.contentView,10).centerXEqualToView(self.contentView).widthIs(240).heightIs(20);
        self.pastInteg.text = @"2016-12-31将过期积分12345个";
       
        
        

        
    }
    return self;
}

- (void)setModel:(YJIntegraModel *)model{
    
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.NoLab.text = model.nickName;
    
    NSString *tol = [NSString stringWithFormat:@"当前可用积分:%@",model.totalUseScore];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tol];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont boldSystemFontOfSize:AdaptedWidth(16.0)]
     
                          range:NSMakeRange(7, model.totalUseScore.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor purpleColor]
     
                          range:NSMakeRange(7, model.totalUseScore.length)];
    
    
    self.userInge.attributedText = AttributedStr;
    
    
    NSString *user = [NSString stringWithFormat:@"2017-12-31过期积分:%@个",model.yearUseScore];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:user];
    
    [AttributedStr1 addAttribute:NSFontAttributeName
     
                          value:[UIFont boldSystemFontOfSize:AdaptedWidth(16.0)]
     
                          range:NSMakeRange(15, model.yearUseScore.length)];
    
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor purpleColor]
     
                          range:NSMakeRange(15, model.yearUseScore.length)];
    
    
    self.pastInteg.attributedText = AttributedStr1;

    
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
