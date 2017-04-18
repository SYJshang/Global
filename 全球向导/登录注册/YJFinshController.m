//
//  YJFinshController.m
//  全球向导
//
//  Created by SYJ on 2016/11/1.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJFinshController.h"
#import "YJFindPWController.h"
#import "SDAutoLayout.h"
#import "YJLoginFirstController.h"

@interface YJFinshController ()

//头部图片
@property (nonatomic, strong) UIImageView *imgV;

@end

@implementation YJFinshController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg3"]];
    [self.view addSubview:self.imgV];
    self.imgV.userInteractionEnabled = YES;
    self.imgV.alpha = 0.7;
    self.imgV.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).heightIs(screen_height);
    
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 30, 20, 16);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.imgV addSubview:btn];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((screen_width / 2) - 50 , 20, 100, 30)];
    label.text = @"找回密码";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.0];
    [self.imgV addSubview:label];
    
    
    UIImageView *finshImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"duihao"]];
    [self.imgV addSubview:finshImg];
    finshImg.sd_layout.centerYEqualToView(self.imgV).centerXEqualToView(self.imgV).heightIs(180.0 * KWidth_Scale).widthIs(180.0 * KWidth_Scale);
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"恭喜你,重置密码成功";
    title.font = [UIFont systemFontOfSize:14.0];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.imgV addSubview:title];
    title.sd_layout.leftSpaceToView(self.imgV,20).rightSpaceToView(self.imgV,20).topSpaceToView(finshImg,20 * KHeight_Scale).heightIs(20);
    
    UIButton *finshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finshBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    finshBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    finshBtn.backgroundColor = TextColor;
    [self.imgV addSubview:finshBtn];
    [finshBtn addTarget:self action:@selector(finshClick) forControlEvents:UIControlEventTouchUpInside];
    finshBtn.sd_layout.topSpaceToView(title,60 * KHeight_Scale).centerXEqualToView(self.view).heightIs(40 * KHeight_Scale).widthIs(240 * KWidth_Scale);
    finshBtn.layer.masksToBounds = YES;
    finshBtn.layer.cornerRadius = 20.0;
    finshBtn.layer.borderColor = [UIColor colorWithRed:255.0 / 255.0 green:230.0 / 255.0 blue:130.0 / 255.0 alpha:1.0].CGColor;
    finshBtn.layer.borderWidth = 1;
    

    
    
    // Do any additional setup after loading the view.
}

- (void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finshClick{
    
    YJLoginFirstController *vc = [[YJLoginFirstController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    
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
