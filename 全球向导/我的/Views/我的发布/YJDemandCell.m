//
//  YJDemandCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/29.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDemandCell.h"

@implementation YJDemandCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *want = [[UILabel alloc]init];
        [self.contentView addSubview:want];
        want.text = @"想找";
        want.textColor = [UIColor grayColor];
        want.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        want.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10 * KHeight_Scale).widthIs(40 * KWidth_Scale).heightIs(15 * KHeight_Scale);

        self.stateLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.stateLab];
        self.stateLab.text = @"生活导师";
        self.stateLab.textColor = TextColor;
        self.stateLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.stateLab.sd_layout.leftSpaceToView(want,10).centerYEqualToView(want).rightSpaceToView(self.contentView,10).heightRatioToView(want,1);
        
        
        UIImageView *money = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"money1"]];
        [self.contentView addSubview:money];
        money.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(want,10 * KHeight_Scale).widthIs(15 * KWidth_Scale).heightIs(15 * KHeight_Scale);
        self.priceLab = [[UILabel alloc]init];
        self.priceLab.text = @"100-200";
        self.priceLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        [self.contentView addSubview:self.priceLab];
        self.priceLab.sd_layout.leftSpaceToView(money,5).centerYEqualToView(money).heightIs(15 * KHeight_Scale).widthIs(80 * KWidth_Scale);
        
        
        self.position = [[UILabel alloc]init];
        self.position.text = @"宁波";
        self.position.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        [self.contentView addSubview:self.position];
        self.position.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(money).heightIs(15 * KHeight_Scale).widthIs(60 * KWidth_Scale);
        UIImageView *posi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"position2"]];
        [self.contentView addSubview:posi];
        posi.sd_layout.rightSpaceToView(self.position,5).centerYEqualToView(self.position).heightIs(15 * KHeight_Scale).widthIs(13 * KWidth_Scale);
        
        
        UIImageView *time = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"time"]];
        [self.contentView addSubview:time];
        time.sd_layout.leftSpaceToView(self.priceLab,5).topSpaceToView(want,10 * KHeight_Scale).widthIs(15 * KWidth_Scale).heightIs(15 * KHeight_Scale);
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.text = @"2016/12/28开始";
        self.timeLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        [self.contentView addSubview:self.timeLab];
        self.timeLab.sd_layout.rightSpaceToView(posi,5).centerYEqualToView(money).heightIs(15 * KHeight_Scale).leftSpaceToView(time,5);
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGroundColor;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.timeLab,10 * KHeight_Scale).rightSpaceToView(self.contentView,10).heightIs(1);
        
        
        UILabel *name = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        name.text = @"名称";
        name.textColor = [UIColor grayColor];
        name.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        name.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(line,10 * KHeight_Scale).heightIs(20 * KHeight_Scale).widthIs(40 * KWidth_Scale);
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.text = @"简约,看不一样的世界";
        self.nameLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.nameLab.sd_layout.leftSpaceToView(name,5).rightSpaceToView(self.contentView,10).centerYEqualToView(name).heightIs(15 * KHeight_Scale);

        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = BackGroundColor;
        [self.contentView addSubview:line1];
        line1.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).topSpaceToView(name,10 * KHeight_Scale).heightIs(1);
        
        self.cancelLab = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.cancelLab];
        [self.cancelLab setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelLab.backgroundColor = [UIColor whiteColor];
        [self.cancelLab setTitleColor:TextColor forState:UIControlStateNormal];
        self.cancelLab.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.cancelLab.sd_layout.rightSpaceToView(self.contentView,10).topSpaceToView(line1,5 * KHeight_Scale).heightIs(30 * KHeight_Scale).widthIs(80 * KWidth_Scale);
        self.cancelLab.layer.masksToBounds = YES;
        self.cancelLab.layer.cornerRadius = 15;
        self.cancelLab.layer.borderColor = TextColor.CGColor;
        self.cancelLab.layer.borderWidth = 1.0;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = BackGray;
        [self.contentView addSubview:view];
        view.sd_layout.topSpaceToView(self.cancelLab,5 * KHeight_Scale).leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(10 * KHeight_Scale);
        

        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
