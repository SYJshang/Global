
//
//  YJEveListCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJEveListCell.h"

#define kSpace 10
#define imgWidth ([UIScreen mainScreen].bounds.size.width - 65 - 30)/3//高宽相等


@implementation YJEveListCell

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
    self.textLab.textColor = [UIColor blackColor];
    self.textLab.numberOfLines = 0;
    self.textLab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.textLab sizeToFit];
    self.textLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    self.textLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.timeLab,5).autoHeightRatio(0).rightSpaceToView(self.contentView,10);
    
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:[UIImage imageNamed:@"y_bad"] forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.btn setTitle:@"差评" forState:UIControlStateNormal];
    [self.contentView addSubview:self.btn];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
    self.btn.userInteractionEnabled = NO;
    self.btn.sd_layout.rightSpaceToView(self.contentView, 10).topEqualToView(self.timeLab).heightIs(20).widthIs(45);
    
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0.5).heightIs(0.5);
    
    self.view = [[UIView alloc]init];
    [self.contentView addSubview:self.view];
    self.view.sd_layout.leftSpaceToView(self.contentView, 65).topSpaceToView(self.textLab, 5).bottomSpaceToView(line, 5).rightSpaceToView(self.contentView, 10);
    
}


-(void)configCellWithText:(YJEvaModel *)text
{
    self.textLab.attributedText = [YJEveListCell cellTextAttributed:text.eva];
}

+ (CGFloat)cellHegith:(YJEvaModel *)text
{
    
    CGFloat result = 65;
    if (text.eva.length > 0) {
        result = result + [[self cellTextAttributed:text.eva] boundingRectWithSize:CGSizeMake(screen_width - 2 * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    }
    XXLog(@"%f",result);
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
    self.imgStr = model.picUrls;
    
    if (model.evaValue == 1) {
        [self.btn setImage:[UIImage imageNamed:@"y_good"] forState:UIControlStateNormal];
        [self.btn setTitle:@"好评" forState:UIControlStateNormal];

    }else if (model.evaValue == 2){
        
        [self.btn setImage:[UIImage imageNamed:@"y_normal"] forState:UIControlStateNormal];
        [self.btn setTitle:@"一般" forState:UIControlStateNormal];


    }else if (model.evaValue == 3){
        
        [self.btn setImage:[UIImage imageNamed:@"y_bad"] forState:UIControlStateNormal];
        [self.btn setTitle:@"差评" forState:UIControlStateNormal];

        
    }else{
        [self.btn setImage:[UIImage imageNamed:@"y_good"] forState:UIControlStateNormal];
        [self.btn setTitle:@"好评" forState:UIControlStateNormal];

    }
    
    [self imageViewWithImg:model.picUrls];

    
    
    
}


-(void)imageViewWithImg:(NSString *)imgName{
    
    
//    self.view = [[UIView alloc]init];
    
    if (imgName != nil && ![imgName isKindOfClass:[NSNull class]] && ![imgName isEqualToString:@""]){
        
        NSArray *imgs = [imgName componentsSeparatedByString:@","];
        
        
        for (NSInteger i = 0; i < imgs.count;i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kSpace+imgWidth)*(i%3),(kSpace+imgWidth)*(i/3), imgWidth, imgWidth)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[i]] placeholderImage:[UIImage imageNamed:@"horse"]];
            //        imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            [self.view addSubview:imageView];
        }

        
    }else{
        
        self.view = nil;
    }
    
}


-(void)tapAction:(UITapGestureRecognizer *)tap{
   
    NSArray *imgs = [self.imgStr componentsSeparatedByString:@","];

    if (_myDelegate && [_myDelegate respondsToSelector:@selector(checkImage:)]) {
        [_myDelegate checkImage:imgs[tap.view.tag]];
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
