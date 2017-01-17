//
//  YJPictureCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/14.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPictureCell.h"

@implementation YJPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg2"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 5;
        self.icon.layer.borderColor = BackGray.CGColor;
        self.icon.layer.borderWidth = 1.0;
        
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
