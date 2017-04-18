
//
//  YJOtherDemandCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/30.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//



#import "YJOtherDemandCell.h"

static const CGFloat KTopSpace = 10;
static const CGFloat KLeftSpace = 15;
static const CGFloat KTextLabelFontSize = 15;

@implementation YJOtherDemandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [[UILabel alloc]init];
        self.name.text = @"人数";
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.name];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.name.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).heightIs(20 * KHeight_Scale).widthIs(80 * KWidth_Scale);
        
        
        self.desc = [[UILabel alloc]init];
        self.desc.text = @"10人";
        [self.contentView addSubview:self.desc];
        self.desc.numberOfLines = 0;
        [self.desc sizeToFit];
        self.desc.textColor = [UIColor grayColor];
        self.desc.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        self.desc.sd_layout.leftSpaceToView(self.name,5).topSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,10 * KHeight_Scale).rightSpaceToView(self.contentView,10);
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BackGroundColor;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}


-(void)configCellWithText:(NSString *)text
{
    
    self.desc.attributedText = [YJOtherDemandCell cellTextAttributed:text];
}

+(CGFloat)cellHegith:(NSString *)text
{
    CGFloat result = 6 * AdaptedHeight(10);
    if (text.length > 0) {
        result = [[self cellTextAttributed:text] boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
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
