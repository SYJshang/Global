//
//  YJServerStateCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJServerStateCell.h"

@implementation YJServerStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = BackGray;
        [self.contentView addSubview:view];
        view.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).heightIs(10);
        

        
        self.icon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(view,15 * KHeight_Scale).widthIs(60 * KWidth_Scale).heightIs(60 * KHeight_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.width / 2;
        self.icon.layer.borderColor = BackGray.CGColor;
        self.icon.layer.borderWidth = 0.5;
        
        self.server = [[UILabel alloc]init];
        [self.contentView addSubview:self.server];
        self.server.textColor = [UIColor blackColor];
        self.server.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
        self.server.sd_layout.leftSpaceToView(self.icon,10).topSpaceToView(view,(self.icon.centerY - 8) * KHeight_Scale).widthIs(100 * KWidth_Scale).heightIs(20 * KHeight_Scale);

        self.descLab = [[UILabel alloc]init];
        self.descLab.textColor = [UIColor grayColor];
        self.descLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        [self.contentView addSubview:self.descLab];
        self.descLab.sd_layout.leftEqualToView(self.server).topSpaceToView(self.server,5).heightIs(20 * KHeight_Scale).widthIs(130 * KWidth_Scale);
        
        self.priceLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.priceLab];
        self.priceLab.textColor = [UIColor blackColor];
        self.priceLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.priceLab.text = @"￥98.00";
        self.priceLab.textAlignment = NSTextAlignmentRight;
        self.priceLab.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.descLab).heightIs(20 * KHeight_Scale).widthIs(80 * KWidth_Scale);

        self.stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.stateBtn];
        [self.stateBtn setTitle:@"启用" forState:UIControlStateNormal];
        [self.stateBtn setBackgroundColor:TextColor];
        [self.stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.stateBtn.selected = YES;
        self.stateBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.stateBtn addTarget:self action:@selector(stataClick:) forControlEvents:UIControlEventTouchUpInside];
        self.stateBtn.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(self.descLab,10).heightIs(25 * KHeight_Scale).widthIs(70 * KWidth_Scale);
        self.stateBtn.layer.masksToBounds = YES;
        self.stateBtn.layer.cornerRadius = 12;
        self.stateBtn.layer.borderColor = BackGray.CGColor;
        self.stateBtn.layer.borderWidth = 0.5;
        
        
        
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.editBtn];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
        self.editBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.editBtn.sd_layout.rightSpaceToView(self.stateBtn,10).topSpaceToView(self.priceLab,10).heightIs(25 * KHeight_Scale).widthIs(70 * KWidth_Scale);
        self.editBtn.layer.masksToBounds = YES;
        self.editBtn.layer.cornerRadius = 12;
        self.editBtn.layer.borderColor = BackGray.CGColor;
        self.editBtn.layer.borderWidth = 0.5;
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void)stataClick:(UIButton *)btn{
    
    if (btn.selected == YES) {
        
        [UIView animateWithDuration:0.5 animations:^{
            btn.selected = NO;
            [btn setBackgroundColor:[UIColor grayColor]];
            [btn setTitle:@"停用" forState:UIControlStateNormal];
            btn.layer.borderColor = TextColor.CGColor;
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            btn.selected = YES;
            [btn setBackgroundColor:TextColor];
            [btn setTitle:@"接单" forState:UIControlStateNormal];
            btn.layer.borderColor = BackGray.CGColor;
   
        }];
    }
}

- (void)editClick:(UIButton *)btn{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(editClickPush)]) {
        [self.delegate editClickPush];
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
