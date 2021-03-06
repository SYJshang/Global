//
//  YJLoginController.m
//  全球向导
//
//  Created by SYJ on 2016/10/28.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJLoginController.h"
#import "SDAutoLayout.h"
#import "YJTabBarController.h"
#import "YJLoginFirstController.h"
#import "YJRegsiterController.h"


@interface YJLoginController ()

//背景图片
@property (nonatomic, strong) UIImageView *backImg;
//标题
@property (nonatomic, strong) UILabel *titleLab;
//副标题
@property (nonatomic, strong) UILabel *descLab;
//登录按钮
@property (nonatomic, strong) UIButton *loginBtn;
//注册按钮
@property (nonatomic, strong) UIButton *registBtn;
//随便看看
@property (nonatomic, strong) UIButton *move;


@end

@implementation YJLoginController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    //
    [self setView];
    
    
    // Do any additional setup after loading the view.
}


- (void)setView{
    
    [self.view.layer addSublayer: [self backgroundLayer]];
    
//    self.backImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"find_guide"]];
//    self.backImg.alpha = 0.7;
//    self.backImg.userInteractionEnabled = YES;
//    [self.view addSubview:self.backImg];
//    self.backImg.frame = self.view.bounds;
    
    self.titleLab = [[UILabel alloc]init];
    [self.view addSubview:self.titleLab];
    self.titleLab.text = @"GLOBAL";
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(24.0)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,60.0).widthIs(200.0 * KWidth_Scale).heightIs(30.0 * KHeight_Scale);
    
    
    self.descLab = [[UILabel alloc]init];
    [self.view addSubview:self.descLab];
    self.descLab.text = @"全球向导---带你体验不一样的生活！";
    self.descLab.textColor = [UIColor blackColor];
    self.descLab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(18)];
    self.descLab.textAlignment = NSTextAlignmentCenter;
    self.descLab.sd_layout.topSpaceToView(self.titleLab,20).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(20.0);
    
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registBtn];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registBtn.backgroundColor = [UIColor clearColor];
    [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.registBtn.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view,140.0 * KHeight_Scale).heightIs(40.0).widthIs(240.0 * KWidth_Scale);
    self.registBtn.layer.masksToBounds = YES;
    self.registBtn.layer.cornerRadius = 20.0;
    self.registBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registBtn.layer.borderWidth = 1;
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = TextColor;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.registBtn,20).heightIs(40.0).widthIs(240.0 * KWidth_Scale);
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 20.0;
    self.loginBtn.layer.borderColor = [UIColor colorWithRed:255.0 / 255.0 green:230.0 / 255.0 blue:130.0 / 255.0 alpha:1.0].CGColor;
    self.loginBtn.layer.borderWidth = 1;
    
    
    self.move = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.move];
    [self.move setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [self.move setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.move.sd_layout.rightSpaceToView(self.view,10).bottomSpaceToView(self.view,10).heightIs(10.0).widthIs(70.0);
    self.move.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.move addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
//    self.move.layer.masksToBounds = YES;
//    self.move.layer.cornerRadius = 10;
//    self.move.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.move.layer.borderWidth = 2;
}




- (void)loginBtn:(UIButton *)btn{
    YJLoginFirstController *vc = [[YJLoginFirstController alloc]init];
    vc.type = 10;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)registerBtn:(UIButton *)btn{
    YJRegsiterController *vc = [[YJRegsiterController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)move:(UIButton *)btn{
    
    YJTabBarController *vc = [[YJTabBarController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];

}



//背景颜色
-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.2,@1];
    return gradientLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
