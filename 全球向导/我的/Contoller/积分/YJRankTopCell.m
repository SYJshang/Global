//
//  YJRankTopCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJRankTopCell.h"

@implementation YJRankTopCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = TextColor;
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor purpleColor];
        line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10).topSpaceToView(self.contentView, 50);
        
        self.beforeRank = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"level_internship"]];
        [self.contentView addSubview:self.beforeRank];
        self.beforeRank.sd_layout.leftSpaceToView(self.contentView, 30).topSpaceToView(line, 0).widthIs(35).heightIs(40);
        
        self.lastRank = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"level_one"]];
        [self.contentView addSubview:self.lastRank];
        self.lastRank.sd_layout.rightSpaceToView(self.contentView, 30).topSpaceToView(line, 0).widthIs(35).heightIs(40);
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.centerYEqualToView(line).centerXEqualToView(line).widthIs(80).heightIs(80);
        
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 40;
        self.icon.layer.borderColor = BackGroundColor.CGColor;
        self.icon.layer.borderWidth = 0.5;
        
        
        self.rankIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"one_star"]];
        self.rankIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.rankIcon];
        self.rankIcon.sd_layout.topSpaceToView(self.icon, -20).centerXEqualToView(line).widthRatioToView(self.icon, 1).heightIs(20);
        
        
        
        self.nameNoLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameNoLab];
        self.nameNoLab.textAlignment = NSTextAlignmentCenter;
        self.nameNoLab.textColor = [UIColor whiteColor];
        self.nameNoLab.text = @"123456789";
        self.nameNoLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.nameNoLab.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.icon, 20).widthIs(140).heightIs(20);
        
        
        self.integralLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.integralLab];
        self.integralLab.textColor = [UIColor whiteColor];
        self.integralLab.text = @"当前积分成长值:1234567";
        self.integralLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.integralLab.sd_layout.bottomSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10).widthIs(180).heightIs(20);
        
        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.detailBtn];
        [self.detailBtn setTitle:@"明细" forState:UIControlStateNormal];
        [self.detailBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        self.detailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.detailBtn setImageEdgeInsets:UIEdgeInsetsMake(0,33, 0, 0)];
        [self.detailBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 10)];
        self.detailBtn.sd_layout.rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10).widthIs(40).heightIs(20);
    }
    
    return self;
    
}


- (void)setModel:(YJRankModel *)model{
    
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.nameNoLab.text = model.realName;
    
    if (model.grade == 1) {
        
        self.beforeRank.image = [UIImage imageNamed:@"level_internship"];
        self.lastRank.image = [UIImage imageNamed:@"level_one"];
    }else if (model.grade == 2){
        
        self.beforeRank.image = [UIImage imageNamed:@"level_one"];
        self.lastRank.image = [UIImage imageNamed:@"level_two"];
    }else if (model.grade == 3){
        
        self.beforeRank.image = [UIImage imageNamed:@"level_two"];
        self.lastRank.image = [UIImage imageNamed:@"level_three"];
    }else if (model.grade == 4){
        
        self.beforeRank.image = [UIImage imageNamed:@"level_three"];
        self.lastRank.image = [UIImage imageNamed:@"level_five"];
    }else if (model.grade == 5){
        
        self.beforeRank.image = [UIImage imageNamed:@"level_four"];
        self.lastRank.image = [UIImage imageNamed:@"level_five"];
    }else if (model.grade == 6){
        
        self.beforeRank.image = [UIImage imageNamed:@"level_five"];
        self.lastRank.hidden = YES;
    }
    
    
    NSString *tol = [NSString stringWithFormat:@"当前积分成长值:%@",model.totalUseGv];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tol];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont boldSystemFontOfSize:AdaptedWidth(16.0)]
     
                          range:NSMakeRange(8, model.totalUseGv.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor purpleColor]
     
                          range:NSMakeRange(8, model.totalUseGv.length)];
    

    self.integralLab.attributedText = AttributedStr;
    
    
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
