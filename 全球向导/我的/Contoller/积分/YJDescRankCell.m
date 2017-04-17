//
//  YJDescRankCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJDescRankCell.h"

static const CGFloat KTextLabelFontSize = 12;
static const CGFloat KLeftSpace = 10;


@implementation YJDescRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.textLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.textLab];
        self.textLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.textLab.textColor = [UIColor lightGrayColor];
//        self.textLab.text = @"成交金额:1元=1个成长值\n客户评分:一个好评=10个成长值;一般=0个成长值;一个差评=-10个成长值;\n发展向导:发展1人=50个成长值;\n攻略分享:发表一篇=10个成长值;\n每日登陆:1个成长值";
        self.textLab.numberOfLines = 0;
        [self.textLab sizeToFit];
        self.textLab.sd_layout.leftSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
        

//        

        
    }
    
    return self;
}


-(void)configCellWithText:(NSString *)text
{
    
    self.textLab.attributedText = [YJDescRankCell cellTextAttributed:text];
}

+(CGFloat)cellHegith:(NSString *)text
{
    CGFloat result = 3 * AdaptedHeight(10);
    if (text.length > 0) {
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
