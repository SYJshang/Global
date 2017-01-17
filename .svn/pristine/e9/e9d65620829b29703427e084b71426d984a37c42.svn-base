//
//  YJFirstCell.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJFirstCell.h"



#define Height  CGRectGetHeight([UIScreen mainScreen].bounds)
#define Width   CGRectGetWidth([UIScreen mainScreen].bounds)

@interface YJFirstCell ()<SDCycleScrollViewDelegate>

@end

@implementation YJFirstCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.imagesURLStrings = @[
//                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                      ];
        
        // 情景三：图片配文字
//        self.titleArr = @[@"新建交流QQ群：185534916",
//                            @"感谢您的支持，如果下载的",
//                            @"如果代码在使用过程中出现问题",
//                            @"您可以发邮件到gsdios@126.com"
//                            ];
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, Width - 20, 170 * KHeight_Scale) delegate:self placeholderImage:[UIImage imageNamed:@"backImg"]];
        self.cycleScrollView.layer.masksToBounds = YES;
        self.cycleScrollView.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.cycleScrollView.layer.borderWidth = 2;
        self.cycleScrollView.layer.cornerRadius = 5;

        
        
        
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.cycleScrollView.titleLabelTextAliment = SDCycleScrollViewTitleLabelAlimntCenter;
        self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        self.cycleScrollView.titlesGroup = self.titleArr;
        self.cycleScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
        [self.contentView addSubview:self.cycleScrollView];

        self.cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
        
        
    }
    return self;
}

- (void)setImagesURLStrings:(NSMutableArray *)imagesURLStrings{
    
    _imagesURLStrings = imagesURLStrings;
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
}

- (void)setTitleArr:(NSMutableArray *)titleArr{
    _titleArr = titleArr;
    self.cycleScrollView.titlesGroup = titleArr;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    if ([self.delegate respondsToSelector:@selector(Lunbo:)]) {
        // 调用代理对象的登录方法，代理对象去实现登录方法
        [self.delegate Lunbo:index];
    }
    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
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
