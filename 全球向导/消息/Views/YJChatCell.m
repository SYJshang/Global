
//
//  YJChatCell.m
//  全球向导
//
//  Created by SYJ on 2017/3/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJChatCell.h"

@implementation YJChatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HeaderIcon"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.centerYEqualToView(self.contentView).heightIs(65).widthIs(65).leftSpaceToView(self.contentView,10);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.width / 2;
        self.icon.layer.borderColor = BackGray.CGColor;
        self.icon.layer.borderWidth = 1.0;
        
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.textColor = [UIColor blackColor];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(17)];
        self.name.sd_layout.leftSpaceToView(self.icon, 10).topSpaceToView(self.contentView, 20).widthIs(100).heightIs(20);
        
        self.message = [[UILabel alloc]init];
        [self.contentView addSubview:self.message];
        self.message.textColor = [UIColor lightGrayColor];
        self.message.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.message.sd_layout.leftSpaceToView(self.icon, 10).bottomSpaceToView(self.contentView, 15).widthIs(150).heightIs(20);
        
        self.time = [[UILabel alloc]init];
        [self.contentView addSubview:self.time];
        self.time.textColor = [UIColor lightGrayColor];
        self.time.textAlignment = NSTextAlignmentRight;
        self.time.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.time.sd_layout.rightSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).widthIs(100).heightIs(15);
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = BackGray;
        line.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 1).heightIs(1);

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
