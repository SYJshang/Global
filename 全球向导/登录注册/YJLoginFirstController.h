//
//  YJRegisteController.h
//  全球向导
//
//  Created by SYJ on 2016/10/28.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLoginFirstController : UIViewController



//登录
@property (nonatomic, strong) UIButton *loginBtn;
//注册
@property (nonatomic, strong) UIButton *registerBtn;

//名称、手机号
@property (nonatomic, strong) UITextField *nameTf;

@property (nonatomic, assign) NSInteger type;


@end
