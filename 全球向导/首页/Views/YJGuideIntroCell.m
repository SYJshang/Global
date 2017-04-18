//
//  YJGuideIntroCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGuideIntroCell.h"

@implementation YJGuideIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        
        self.backgroundColor = BackGray;
    }
    
    return self;
    
}

- (void)initView{
    
    
    self.unfoldBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) title:@"点击展开" imageName:@"pick-in" Block:^{
        
        
                if (self.unfoldBtn.selected == YES) {
        
                    self.unfoldBtn.selected = NO;
                    [self.unfoldBtn setTitle:@"点击收起" forState:UIControlStateNormal];
                    [self.unfoldBtn setImage:[UIImage imageNamed:@"pack-up"] forState:UIControlStateNormal];
        
                }else{
        
                    self.unfoldBtn.selected = YES;
                    [self.unfoldBtn setTitle:@"点击展开" forState:UIControlStateNormal];
                    [self.unfoldBtn setImage:[UIImage imageNamed:@"pick-in"] forState:UIControlStateNormal];
                }

        
        if ([self.delegate respondsToSelector:@selector(introDetail:)]) {
            // 调用代理对象的登录方法，代理对象去实现登录方法
            [self.delegate introDetail:self.unfoldBtn.selected];
        }
        
        
    }];
    
    [self.contentView addSubview:self.unfoldBtn];
    self.unfoldBtn.selected = YES;
    [self.unfoldBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIColor *col = [UIColor colorWithRed:35.0 / 255.0 green:125.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    [self.unfoldBtn setTitleColor:col forState:UIControlStateNormal];
    self.unfoldBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
    self.unfoldBtn.sd_layout.rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,5).heightIs(15).widthIs(60);
    [self.unfoldBtn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 0)];
    [self.unfoldBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    

    
    self.introLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.introLab];
    self.introLab.textColor = [UIColor blackColor];
    self.introLab.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.introLab.numberOfLines = 0;
    [self.introLab sizeToFit];
    self.introLab.lineBreakMode = NSLineBreakByWordWrapping;

    self.introLab.text = @"所有这些布局都采用了同样的数据源和委托方法，因此完全实现了model和view的解耦。但是如果仅这样，那开源社区也已经有很多相应的解决方案了。Apple的强大和开源社区不能比拟的地方在于对SDK的全局掌控，CollectionView提供了非常简单的API可以令开发者只需要一次简单调用，就可以使用CoreAnimation在不同的layout之间进行动画切换，这种切换必定将大幅增加用户体验，代价只是几十行代码就能完成的布局实现，以及简单的一句API调用，不得不说现在所有的开源代码与之相比，都是相形见拙了…不得不佩服和感谢UIKit团队的努力";
    self.introLab.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.unfoldBtn,5);
    
    
    UIView *line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,0.5).heightIs(0.5);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    

}
-(void)configCellWithText:(YJGuideModel *)text
{
    self.introLab.attributedText = [YJGuideIntroCell cellTextAttributed:text.summary];
}

+ (CGFloat)cellHegith:(YJGuideModel *)text
{
    
        CGFloat result = 50;
        if (text.summary.length > 0) {
            result = result + [[self cellTextAttributed:text.summary] boundingRectWithSize:CGSizeMake(screen_width - 2 * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
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




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
