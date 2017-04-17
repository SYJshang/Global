//
//  YJRankRuleCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJRankRuleCell.h"

@implementation YJRankRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        view.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10);
        
        //星级
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor lightGrayColor];
        [view addSubview:name];
        name.textAlignment = NSTextAlignmentCenter;
        name.text = @"星级";
        name.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        name.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(view, 0);
        name.layer.masksToBounds = YES;
        name.layer.cornerRadius = 1;
        name.layer.borderColor = BackGray.CGColor;
        name.layer.borderWidth = 0.5;
        
        UILabel *noRank = [[UILabel alloc]init];
        noRank.textColor = [UIColor lightGrayColor];
        [view addSubview:noRank];
        noRank.textAlignment = NSTextAlignmentCenter;
        noRank.text = @"无星级";
        noRank.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        noRank.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(name, 0);
        noRank.layer.masksToBounds = YES;
        noRank.layer.cornerRadius = 1;
        noRank.layer.borderColor = BackGray.CGColor;
        noRank.layer.borderWidth = 0.5;
        
        UIImageView *oneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_star"]];
//        oneImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:oneImg];
        oneImg.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(noRank, 0);
        oneImg.layer.masksToBounds = YES;
        oneImg.layer.cornerRadius = 1;
        oneImg.layer.borderColor = BackGray.CGColor;
        oneImg.layer.borderWidth = 0.5;
        
        UIImageView *twoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"second_star"]];
//        twoImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:twoImg];
        twoImg.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(oneImg, 0);
        twoImg.layer.masksToBounds = YES;
        twoImg.layer.cornerRadius = 1;
        twoImg.layer.borderColor = BackGray.CGColor;
        twoImg.layer.borderWidth = 0.5;
        
        UIImageView *threeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"third_star"]];
//        threeImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:threeImg];
        threeImg.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(twoImg, 0);
        threeImg.layer.masksToBounds = YES;
        threeImg.layer.cornerRadius = 1;
        threeImg.layer.borderColor = BackGray.CGColor;
        threeImg.layer.borderWidth = 0.5;
        
        UIImageView *fourImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fourth_star"]];
//        fourImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:fourImg];
        fourImg.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(threeImg, 0);
        fourImg.layer.masksToBounds = YES;
        fourImg.layer.cornerRadius = 1;
        fourImg.layer.borderColor = BackGray.CGColor;
        fourImg.layer.borderWidth = 0.5;
        
        UIImageView *fiveImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fifth_star"]];
//        fiveImg.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:fiveImg];
        fiveImg.sd_layout.leftSpaceToView(view, 0).widthIs(80).heightIs(30).topSpaceToView(fourImg, 0);
        fiveImg.layer.masksToBounds = YES;
        fiveImg.layer.cornerRadius = 1;
        fiveImg.layer.borderColor = BackGray.CGColor;
        fiveImg.layer.borderWidth = 0.5;
        

        //称谓
        UILabel *desc = [[UILabel alloc]init];
        desc.textColor = [UIColor lightGrayColor];
        [view addSubview:desc];
        desc.text = @"称谓";
        desc.textAlignment = NSTextAlignmentCenter;
        desc.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        desc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(view, 0);
        desc.layer.masksToBounds = YES;
        desc.layer.cornerRadius = 1;
        desc.layer.borderColor = BackGray.CGColor;
        desc.layer.borderWidth = 0.5;
        
        UILabel *noDesc = [[UILabel alloc]init];
        noDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:noDesc];
        noDesc.text = @"实习向导";
        noDesc.textAlignment = NSTextAlignmentCenter;
        noDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        noDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(desc, 0);
        noDesc.layer.masksToBounds = YES;
        noDesc.layer.cornerRadius = 1;
        noDesc.layer.borderColor = BackGray.CGColor;
        noDesc.layer.borderWidth = 0.5;
        
        UILabel *oneDesc = [[UILabel alloc]init];
        oneDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:oneDesc];
        oneDesc.text = @"一星向导";
        oneDesc.textAlignment = NSTextAlignmentCenter;
        oneDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        oneDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(noDesc, 0);
        oneDesc.layer.masksToBounds = YES;
        oneDesc.layer.cornerRadius = 1;
        oneDesc.layer.borderColor = BackGray.CGColor;
        oneDesc.layer.borderWidth = 0.5;

        UILabel *twoDesc = [[UILabel alloc]init];
        twoDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:twoDesc];
        twoDesc.text = @"二星向导";
        twoDesc.textAlignment = NSTextAlignmentCenter;
        twoDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        twoDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(oneDesc, 0);
        twoDesc.layer.masksToBounds = YES;
        twoDesc.layer.cornerRadius = 1;
        twoDesc.layer.borderColor = BackGray.CGColor;
        twoDesc.layer.borderWidth = 0.5;
        
        UILabel *threeDesc = [[UILabel alloc]init];
        threeDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:threeDesc];
        threeDesc.text = @"三星向导";
        threeDesc.textAlignment = NSTextAlignmentCenter;
        threeDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        threeDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(twoDesc, 0);
        threeDesc.layer.masksToBounds = YES;
        threeDesc.layer.cornerRadius = 1;
        threeDesc.layer.borderColor = BackGray.CGColor;
        threeDesc.layer.borderWidth = 0.5;
        
        UILabel *fourDesc = [[UILabel alloc]init];
        fourDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:fourDesc];
        fourDesc.text = @"四星向导";
        fourDesc.textAlignment = NSTextAlignmentCenter;
        fourDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        fourDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(threeDesc, 0);
        fourDesc.layer.masksToBounds = YES;
        fourDesc.layer.cornerRadius = 1;
        fourDesc.layer.borderColor = BackGray.CGColor;
        fourDesc.layer.borderWidth = 0.5;
        
        UILabel *fiveDesc = [[UILabel alloc]init];
        fiveDesc.textColor = [UIColor lightGrayColor];
        [view addSubview:fiveDesc];
        fiveDesc.text = @"五星向导";
        fiveDesc.textAlignment = NSTextAlignmentCenter;
        fiveDesc.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        fiveDesc.sd_layout.leftSpaceToView(name, 0).widthIs(60).heightIs(30).topSpaceToView(fourDesc, 0);
        fiveDesc.layer.masksToBounds = YES;
        fiveDesc.layer.cornerRadius = 1;
        fiveDesc.layer.borderColor = BackGray.CGColor;
        fiveDesc.layer.borderWidth = 0.5;
        
        //成长值
        UILabel *cheng = [[UILabel alloc]init];
        cheng.textColor = [UIColor lightGrayColor];
        [view addSubview:cheng];
        cheng.text = @"成长值";
        cheng.textAlignment = NSTextAlignmentCenter;
        cheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        cheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(view, 0);
        cheng.layer.masksToBounds = YES;
        cheng.layer.cornerRadius = 1;
        cheng.layer.borderColor = BackGray.CGColor;
        cheng.layer.borderWidth = 0.5;
        
        UILabel *noCheng = [[UILabel alloc]init];
        noCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:noCheng];
        noCheng.text = @"0-9999";
        noCheng.textAlignment = NSTextAlignmentCenter;
        noCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        noCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(cheng, 0);
        noCheng.layer.masksToBounds = YES;
        noCheng.layer.cornerRadius = 1;
        noCheng.layer.borderColor = BackGray.CGColor;
        noCheng.layer.borderWidth = 0.5;
       
        UILabel *oneCheng = [[UILabel alloc]init];
        oneCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:oneCheng];
        oneCheng.text = @"10000-29999";
        oneCheng.textAlignment = NSTextAlignmentCenter;
        oneCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        oneCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(noCheng, 0);
        oneCheng.layer.masksToBounds = YES;
        oneCheng.layer.cornerRadius = 1;
        oneCheng.layer.borderColor = BackGray.CGColor;
        oneCheng.layer.borderWidth = 0.5;
        
        UILabel *twoCheng = [[UILabel alloc]init];
        twoCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:twoCheng];
        twoCheng.text = @"30000-99999";
        twoCheng.textAlignment = NSTextAlignmentCenter;
        twoCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        twoCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(oneCheng, 0);
        twoCheng.layer.masksToBounds = YES;
        twoCheng.layer.cornerRadius = 1;
        twoCheng.layer.borderColor = BackGray.CGColor;
        twoCheng.layer.borderWidth = 0.5;
        
        
        UILabel *threeCheng = [[UILabel alloc]init];
        threeCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:threeCheng];
        threeCheng.text = @"100000-499999";
        threeCheng.textAlignment = NSTextAlignmentCenter;
        threeCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        threeCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(twoCheng, 0);
        threeCheng.layer.masksToBounds = YES;
        threeCheng.layer.cornerRadius = 1;
        threeCheng.layer.borderColor = BackGray.CGColor;
        threeCheng.layer.borderWidth = 0.5;
        
        UILabel *fourCheng = [[UILabel alloc]init];
        fourCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:fourCheng];
        fourCheng.text = @"499999-999999";
        fourCheng.textAlignment = NSTextAlignmentCenter;
        fourCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        fourCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(threeCheng, 0);
        fourCheng.layer.masksToBounds = YES;
        fourCheng.layer.cornerRadius = 1;
        fourCheng.layer.borderColor = BackGray.CGColor;
        fourCheng.layer.borderWidth = 0.5;
        
        UILabel *fiveCheng = [[UILabel alloc]init];
        fiveCheng.textColor = [UIColor lightGrayColor];
        [view addSubview:fiveCheng];
        fiveCheng.text = @"1000000以上";
        fiveCheng.textAlignment = NSTextAlignmentCenter;
        fiveCheng.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        fiveCheng.sd_layout.leftSpaceToView(desc, 0).widthIs(screen_width - 160).heightIs(30).topSpaceToView(fourCheng, 0);
        fiveCheng.layer.masksToBounds = YES;
        fiveCheng.layer.cornerRadius = 1;
        fiveCheng.layer.borderColor = BackGray.CGColor;
        fiveCheng.layer.borderWidth = 0.5;
        
    }
    
    return self;
    
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
