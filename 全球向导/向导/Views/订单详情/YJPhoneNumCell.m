//
//  YJPhoneNumCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPhoneNumCell.h"
#import "SDAutoLayout.h"

@implementation YJPhoneNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.phoneNum = [[UILabel alloc]init];
        self.phoneNum.text = @"联系电话";
        self.phoneNum.textColor = [UIColor blackColor];
        self.phoneNum.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [self.contentView addSubview:self.phoneNum];
        self.phoneNum.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10).widthIs(70.0);
        
        self.phoneTF = [[UITextField alloc]init];
        self.phoneTF.placeholder = @"输入电话（必填）";
        [self.contentView addSubview:self.phoneTF];
        self.phoneTF.delegate = self;
        self.phoneTF.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.phoneTF.sd_layout.leftSpaceToView(self.phoneNum,5).rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10);
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGray;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        

    }
    
    return self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.text) {
        self.text(textField.text);
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
