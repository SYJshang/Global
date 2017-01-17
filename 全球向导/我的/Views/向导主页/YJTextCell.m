//
//  YJTextCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/14.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTextCell.h"
#import "NSString+YJSize.h"

static const CGFloat KTopSpace = 10;
static const CGFloat KLeftSpace = 15;
static const CGFloat KTextLabelFontSize = 15;

@implementation YJTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
        
        [self LayoutLayoutCell];
    }
    return self;
}

-(void)LayoutLayoutCell
{
    if (!self.text) {
        self.text=  [[UILabel alloc]init];
        self.text.textColor=[UIColor grayColor];
        self.text.numberOfLines = 0;
        [self.text sizeToFit];
        [self.contentView addSubview:self.text];
        self.text.font = AdaptedFontSize(KTextLabelFontSize);

        self.text.sd_layout.leftSpaceToView(self.contentView,AdaptedWidth(KLeftSpace)).rightSpaceToView(self.contentView,AdaptedWidth(KLeftSpace)).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
        
    }
    
}
-(void)configCellWithText:(NSString *)text
{
    
    self.text.attributedText = [YJTextCell cellTextAttributed:text];
}

+(CGFloat)cellHegith:(NSString *)text
{
    CGFloat result = 3 * AdaptedHeight(10);
    if (text.length>0) {
        result = result+[[self cellTextAttributed:text] boundingRectWithSize:CGSizeMake(screen_width - 2 * KLeftSpace, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    }
    return result;
}


+(NSAttributedString *)cellTextAttributed:(NSString *)text
{
    //富文本设置文字行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4;
    
    NSDictionary *attributes = @{ NSFontAttributeName:AdaptedFontSize(KTextLabelFontSize), NSParagraphStyleAttributeName:paragraphStyle};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
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
