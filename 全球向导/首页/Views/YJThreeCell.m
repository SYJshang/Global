//
//  YJThreeCell.m
//  全球向导
//
//  Created by SYJ on 2016/10/27.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJThreeCell.h"
#import "UIImageView+WebCache.h"

@implementation YJThreeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123"]];
        [self.contentView addSubview:self.imageV];
        self.imageV.sd_layout.leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).heightIs(160.0 * KWidth_Scale);
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = 8;
        self.imageV.layer.borderWidth = 2;
        self.imageV.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HeaderIcon"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.imageV,10 * KHeight_Scale).heightIs(40 * KWidth_Scale).widthIs(40 * KWidth_Scale);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.height / 2;
        self.icon.layer.borderWidth = 2;
        self.icon.layer.borderColor =  [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;

        
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.sd_layout.leftSpaceToView(self.icon,5 * KWidth_Scale).topSpaceToView(self.imageV,10 * KWidth_Scale).heightIs(18 * KWidth_Scale).widthIs(75);
        self.name.textColor = [UIColor lightGrayColor];
        self.name.font = [UIFont systemFontOfSize:14.0];
        
        self.position = [[UILabel alloc]init];
        [self.contentView addSubview:self.position];
        self.position.sd_layout.leftSpaceToView(self.icon,5 * KWidth_Scale).topSpaceToView(self.name,2 * KWidth_Scale).heightIs(18 * KWidth_Scale).widthIs(75);
        self.position.textColor = [UIColor lightGrayColor];
        self.position.font = [UIFont systemFontOfSize:13.0];
        
        

        
        self.title = [[UILabel alloc]init];
        [self.contentView addSubview:self.title];
        self.title.sd_layout.centerYEqualToView(self.name).rightSpaceToView(self.contentView,10).leftSpaceToView(self.name,10).heightIs(18 * KWidth_Scale);
        self.title.font = [UIFont systemFontOfSize:13.0];
        self.title.textColor = [UIColor lightGrayColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        
        self.descTitle = [[UILabel alloc]init];
        [self.contentView addSubview:self.descTitle];
        self.descTitle.font = [UIFont systemFontOfSize:14.0];
        self.descTitle.textColor = [UIColor lightGrayColor];
        self.descTitle.textAlignment = NSTextAlignmentLeft;
        self.descTitle.sd_layout.centerYEqualToView(self.position).rightSpaceToView(self.contentView,10).heightIs(18 * KWidth_Scale).leftSpaceToView(self.position,10);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setGuideModel:(YJGuideModel *)guideModel{
    
    _guideModel = guideModel;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:guideModel.coverPhotoUrl] placeholderImage:[UIImage imageNamed:@"big_horse"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:guideModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
    self.name.text = [NSString stringWithFormat:@"by %@",guideModel.realName];
    NSString *type = [self.guideType objectForKey:guideModel.type];
    if (self.state == 1) {
        self.position.text = [NSString stringWithFormat:@"|%@|",guideModel.guideDesc];

    }else{
        self.position.text = [NSString stringWithFormat:@"|%@|",type];
    }
    self.title.text = [NSString stringWithFormat:@"座右铭: %@",guideModel.motto];
    self.descTitle.text = @"标  签: 带你去看好看的地方";

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
