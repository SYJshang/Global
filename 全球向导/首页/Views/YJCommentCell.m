//
//  YJCommentCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation YJCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = BackGray;

        
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}

- (void)initView{
    
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
    [self.contentView addSubview:self.icon];
    self.icon.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).widthIs(50).heightIs(50);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width /2 ;
    self.icon.layer.borderWidth = 0.5;
    self.icon.layer.borderColor = BackGroundColor.CGColor;
    
    self.nameLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLab];
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.text = @"第一楼";
    self.nameLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.nameLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.contentView,15).heightIs(15).widthIs(150);
    
    self.timeLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.timeLab];
    self.timeLab.textColor = [UIColor lightGrayColor];
    self.timeLab.text = @"8-19 21:34";
    self.timeLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    self.timeLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.nameLab,5).heightIs(15).widthIs(150);
    
    self.textLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.textLab];
    self.textLab.textColor = [UIColor lightGrayColor];
    self.textLab.numberOfLines = 0;
    self.textLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.textLab sizeToFit];
    self.textLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    self.textLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.timeLab,5).bottomSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10);
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0.5).heightIs(0.5);
    
}


-(void)configCellWithText:(YJEvaModel *)text
{
    self.textLab.attributedText = [YJCommentCell cellTextAttributed:text.eva];
}

+ (CGFloat)cellHegith:(YJEvaModel *)text
{
    
    CGFloat result = 65;
    if (text.eva.length > 0) {
        result = result + [[self cellTextAttributed:text.eva] boundingRectWithSize:CGSizeMake(screen_width - 2 * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    }
    return result;
    
}


+ (NSAttributedString *)cellTextAttributed:(NSString *)text
{
    //富文本设置文字行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4;
    
    NSDictionary *attributes = @{ NSFontAttributeName:AdaptedFontSize(14), NSParagraphStyleAttributeName:paragraphStyle};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (void)setModel:(YJEvaModel *)model{
    
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.nameLab.text = model.nickName;
    self.timeLab.text = model.addTime;
    self.textLab.text = model.eva;

    
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
