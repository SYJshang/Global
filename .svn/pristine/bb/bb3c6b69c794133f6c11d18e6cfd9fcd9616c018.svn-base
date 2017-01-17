//
//  YJSecondCell.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSecondCell.h"
#import "UIImageView+WebCache.h"

@implementation YJSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImage *abc = [UIImage imageNamed:@"bg2"];
        self.imageV = [[UIImageView alloc]initWithImage:abc];
        [self.contentView addSubview:self.imageV];
        self.imageV.sd_layout.leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = 8;
        self.imageV.layer.borderWidth = 2;
        self.imageV.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        
        self.title = [[UILabel alloc]init];
        [self.imageV addSubview:self.title];
        self.title.text = @"将你需要每次启动的东西放在将你需要";
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont boldSystemFontOfSize:AdaptedWidth(16)];
        self.title.textColor = [UIColor whiteColor];
        self.title.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.imageV,60 * KHeight_Scale).heightIs(20).widthIs(screen_width - 20);
        
        
        self.descTitle = [[UILabel alloc]init];
        [self.imageV addSubview:self.descTitle];
        self.descTitle.textAlignment = NSTextAlignmentCenter;
        self.descTitle.text = @"将你需要每次启动";
        self.descTitle.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.descTitle.textColor = [UIColor whiteColor];
        self.descTitle.sd_layout.centerXEqualToView(self.title).topSpaceToView(self.title,10 * KHeight_Scale).heightIs(20).widthIs(screen_width - 20);
        
        self.num = [[UILabel alloc]init];
        [self.imageV addSubview:self.num];
        self.num.sd_layout.rightSpaceToView(self.imageV,10).bottomSpaceToView(self.imageV,10).heightIs(20).widthIs(150);
        self.num.text = @"浏览次数 9999";
        self.num.textColor = [UIColor whiteColor];
        self.num.font = [UIFont systemFontOfSize:13.0];
        self.num.textAlignment = NSTextAlignmentRight;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
    }
    
    return self;
}

- (void)setShareList:(YJNearbyModel *)shareList{
    
    _shareList = shareList;
    self.title.text = shareList.bigTitle;
    self.descTitle.text = shareList.smallTitle;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:shareList.coverPicUrl] placeholderImage:[UIImage imageNamed:@"bg2"]];
    self.num.text = [NSString stringWithFormat:@"收藏数:%@",shareList.colNumber];
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
