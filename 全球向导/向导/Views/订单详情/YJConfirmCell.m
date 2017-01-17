//
//  YJConfirmCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJConfirmCell.h"
#import "SDAutoLayout.h"

@implementation YJConfirmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.font = [UIFont systemFontOfSize:15.0];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.text = @"李小元/巴黎向导";
        self.name.textColor = [UIColor blackColor];
        self.name.sd_layout.heightIs(20).bottomSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,20).rightSpaceToView(self.contentView,20);
        
        
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"portrait"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.centerXEqualToView(self.contentView).bottomSpaceToView(self.name,5).widthIs(80).heightIs(80);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.width / 2;
        self.icon.layer.borderColor = BackGray.CGColor;
        self.icon.layer.borderWidth = 1;
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGray;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        
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
