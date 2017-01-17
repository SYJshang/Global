//
//  YJStateCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJStateModle.h"

@interface YJStateCell : UITableViewCell

@property (nonatomic,strong)YJStateModle * model;

@property (nonatomic,strong)UILabel * verticalLabel1; //竖线
@property (nonatomic,strong)UILabel * verticalLabel2; //竖线
@property (nonatomic,strong)UIButton* circleView;     // 圈
@property (nonatomic,strong)UILabel * titleLabel;     //标题
@property (nonatomic,strong)UILabel * detailLabel;    //描述
@property (nonatomic,strong)UILabel * timeLabel;      //时间


@end
