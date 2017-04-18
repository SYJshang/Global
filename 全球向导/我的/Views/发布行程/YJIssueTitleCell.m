//
//  YJIssueTitleCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJIssueTitleCell.h"

@implementation YJIssueTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textView = [[UITextView alloc]init];
        [self.contentView addSubview:self.textView];
        self.textView.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,5);
//        self.textView.placeholder = @"输入标题（20字以内）";
//        self.textView.limitLength = @20;
        self.textView.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.textView.textColor = [UIColor colorWithRed:70.0 / 255.0 green:70.0 / 255.0 blue:70.0 / 255.0 alpha:1.0];
        self.textView.layer.masksToBounds = YES;
        self.textView.layer.cornerRadius = 5;
        self.textView.layer.borderColor = BackGroundColor.CGColor;
        self.textView.layer.borderWidth = 0.5;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
