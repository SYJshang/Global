//
//  YJPlusCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJPlusCell.h"

@implementation YJPlusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.plusBtn setImage:[UIImage imageNamed:@"addhao"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.plusBtn];
        self.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView(self.contentView).heightIs(50).widthIs(50);
        self.plusBtn.layer.masksToBounds = YES;
        self.plusBtn.layer.cornerRadius = self.plusBtn.width / 2;
        self.plusBtn.layer.borderColor = TextColor.CGColor;
        self.plusBtn.layer.borderWidth = 1;
        [self.plusBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

- (void)action{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
        
    }];
    
    
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
