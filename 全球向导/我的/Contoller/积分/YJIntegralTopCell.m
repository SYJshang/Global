
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
        
        self.NoLab = [[UILabel alloc]init];
        [view addSubview:self.NoLab];
        self.NoLab.textColor = [UIColor whiteColor];
        self.NoLab.textAlignment = NSTextAlignmentCenter;
        self.NoLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.NoLab.sd_layout.topSpaceToView(self.icon, 5).centerXEqualToView(self.icon).widthIs(150).heightIs(20);
        self.NoLab.text = @"123456789";
        
        self.userInge = [[UILabel alloc]init];
        [view addSubview:self.userInge];
        self.userInge.textColor = [UIColor blackColor];
        self.userInge.textAlignment = NSTextAlignmentCenter;
        self.userInge.font = [UIFont boldSystemFontOfSize:AdaptedWidth(15)];
        self.userInge.sd_layout.bottomSpaceToView(view,-10).centerXEqualToView(self.icon).widthIs(160).heightIs(30);
        self.userInge.text = @"可用积分:1231234";
        self.userInge.layer.masksToBounds = YES;
        self.userInge.layer.cornerRadius = 12;
        self.userInge.layer.borderColor = BackGray.CGColor;
        self.userInge.layer.borderWidth = 1.0;
        
        self.pastInteg = [[UILabel alloc]init];
        [self.contentView addSubview:self.pastInteg];
        self.pastInteg.textColor = [UIColor blackColor];
        self.pastInteg.textAlignment = NSTextAlignmentCenter;
        self.pastInteg.font = [UIFont boldSystemFontOfSize:AdaptedWidth(15)];
        self.pastInteg.sd_layout.bottomSpaceToView(self.contentView,10).centerXEqualToView(self.contentView).widthIs(240).heightIs(20);
        self.pastInteg.text = @"2016-12-31将过期积分12345个";

        
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
