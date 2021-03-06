//
//  YJShareCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/19.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJShareCell.h"

@implementation YJShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        UIImage *abc = [UIImage imageNamed:@"big_horse"];
        self.imageV = [[UIImageView alloc]initWithImage:abc];
        [self.contentView addSubview:self.imageV];
        self.imageV.sd_layout.leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
    }
    
    return self;
    
}
- (void)setModel:(YJNearbyModel *)model{
    
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPicUrl] placeholderImage:[UIImage imageNamed:@"big_horse"]];
    self.title.text = model.bigTitle;
    self.descTitle.text = model.smallTitle;
    
    
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
