//
//  YJProfileCell.m
//  全球向导
//
//  Created by SYJ on 2016/11/4.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJProfileCell.h"

@implementation YJProfileCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //第一个按钮
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view1];
        view1.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).widthIs(screen_width / 2);
        UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Action:)];
        gester.numberOfTapsRequired = 1;
        [view1 addGestureRecognizer:gester];

        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor lightGrayColor];
        [view1 addSubview:line1];
        line1.sd_layout.rightSpaceToView(view1,0).topSpaceToView(view1,10).bottomSpaceToView(view1,10).widthIs(0.5);
        
        self.publishImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"publish"]];
        [view1 addSubview:self.publishImg];
        self.publishImg.sd_layout.centerXEqualToView(view1).centerYEqualToView(view1).widthIs(50 * KWidth_Scale).heightIs(KWidth_Scale * 50).topSpaceToView(view1,15);
        
        self.publishLab = [[UILabel alloc]init];
        self.publishLab.text = YJLocalizedString(@"发布");
        self.publishLab.textColor = [UIColor grayColor];
        self.publishLab.font = [UIFont systemFontOfSize:14.0];
        self.publishLab.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:self.publishLab];
        self.publishLab.sd_layout.leftSpaceToView(view1,10).rightSpaceToView(view1,10).topSpaceToView(self.publishImg,2).heightIs(15);
        
        
        
        
        //第二个按钮
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view2];
        view2.sd_layout.leftSpaceToView(self.contentView,(screen_width / 2)).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).widthIs(screen_width / 2);
        UITapGestureRecognizer *gester1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Action:)];
        gester1.numberOfTapsRequired = 1;
        [view2 addGestureRecognizer:gester1];
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor lightGrayColor];
        [view2 addSubview:line2];
        line2.sd_layout.rightSpaceToView(view2,0).topSpaceToView(view2,10).bottomSpaceToView(view2,10).widthIs(0.5);
        
        self.collectImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"collecion"]];
        [view2 addSubview:self.collectImg];
        self.collectImg.sd_layout.centerXEqualToView(view1).centerYEqualToView(view1).widthIs(KWidth_Scale * 50).heightIs(KWidth_Scale * 50).topSpaceToView(view2,15);
        
        self.collectLab = [[UILabel alloc]init];
        self.collectLab.text = YJLocalizedString(@"收藏");
        self.collectLab.textColor = [UIColor grayColor];
        self.collectLab.font = [UIFont systemFontOfSize:14.0];
        self.collectLab.textAlignment = NSTextAlignmentCenter;
        [view2 addSubview:self.collectLab];
        self.collectLab.sd_layout.leftSpaceToView(view2,10).rightSpaceToView(view2,10).topSpaceToView(self.collectImg,2).heightIs(15);
        
        view1.tag = 11;
        view2.tag = 12;
        
    }
    
    return self;
}

//第一个按钮点击事件
- (void)view1Action:(UITapGestureRecognizer *)sender{
    
    NSInteger tap = sender.view.tag;
    
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(btnDidClickPlusButton:)]) {
        [self.delegate btnDidClickPlusButton:tap];
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
