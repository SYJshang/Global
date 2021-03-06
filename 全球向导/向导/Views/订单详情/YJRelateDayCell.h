//
//  YJRelateDayCell.h
//  全球向导
//
//  Created by SYJ on 2017/1/19.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

//添加代理，用于按钮加减的实现
@protocol MyCustomCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end

//typedef void (^addBlock)(UIButton *sender);//定义block


@interface YJRelateDayCell : UITableViewCell


//人数
@property (nonatomic, strong) UILabel *num;
//人数
@property (nonatomic, strong) UILabel *numLab;
//描述
@property (nonatomic, strong) UILabel *descLab;
//减号按钮
@property (nonatomic, strong) UIButton *reduceBtn;
//加号按钮
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, assign) int people;

//@property (nonatomic, copy) addBlock btnBlock;

@property(assign,nonatomic)id<MyCustomCellDelegate>delegate;




@end
