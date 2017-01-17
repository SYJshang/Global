//
//  YJSetUserInfoVC.m
//  全球向导
//
//  Created by SYJ on 2017/1/3.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJSetUserInfoVC.h"

@interface YJSetUserInfoVC ()

@property (nonatomic, strong) UITextField *userNickTf;

@end

@implementation YJSetUserInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"完成" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"修改昵称" font:19.0];
}

- (void)finsh{
    
    XXLog(@"%@",self.userNickTf.text);
    if (self.nickName && self.userNickTf.text.length < 20) {
        self.nickName(self.userNickTf.text);
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户长度不能超过20" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNickTf = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, screen_width- 20, 40)];
    [self.view addSubview:self.userNickTf];
    self.userNickTf.borderStyle = UITextBorderStyleRoundedRect;
    self.userNickTf.layer.masksToBounds = YES;
    self.userNickTf.layer.cornerRadius = 5;
    self.userNickTf.layer.borderColor = TextColor.CGColor;
    self.userNickTf.layer.borderWidth = 1.0;
    self.userNickTf.placeholder = @"输入昵称";
    
    // Do any additional setup after loading the view.
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
