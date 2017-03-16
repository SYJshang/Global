
//
//  YJDepostionFinshVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJDepostionFinshVC.h"

@interface YJDepostionFinshVC (){
   
    UIImageView *finsh;
    YJDIYButton *depositBtn;
    UILabel *desc;
}


@end

@implementation YJDepostionFinshVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"我的财产" font:19.0];
    
}

- (void)back{
    
    UIViewController *vc = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)initUI{
    
    finsh = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Submit_success"]];
    [self.view addSubview:finsh];
    finsh.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view, 20).heightIs(100 * KWidth_Scale).widthIs(100 * KWidth_Scale);
    
    desc = [[UILabel alloc]init];
    [self.view addSubview:desc];
    desc.text = @"提现申请成功";
    desc.textAlignment = NSTextAlignmentCenter;
    desc.font = [UIFont systemFontOfSize:AdaptedWidth(20)];
    desc.textColor = [UIColor blackColor];
    desc.sd_layout.centerXEqualToView(self.view).topSpaceToView(finsh, 10).heightIs(20).widthIs(200);
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(desc, 20).heightIs(100);
    
    UILabel *name = [[UILabel alloc]init];
    [view addSubview:name];
    name.text = @"支付宝账号";
    name.textColor = [UIColor grayColor];
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    name.sd_layout.leftSpaceToView(view, 10).topSpaceToView(view, 0).heightRatioToView(view, 0.5).widthIs(120);
    
    UILabel *aliAccount = [[UILabel alloc]init];
    [view addSubview:aliAccount];
    aliAccount.textColor = [UIColor grayColor];
    aliAccount.textAlignment = NSTextAlignmentRight;
    aliAccount.text = self.aliAccount;
    aliAccount.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    aliAccount.sd_layout.rightSpaceToView(view, 10).topSpaceToView(view, 0).heightRatioToView(view, 0.5).widthIs(200);
    
    UIView *line = [[UIView alloc]init];
    [view addSubview:line];
    line.backgroundColor = BackGray;
    line.sd_layout.leftSpaceToView(view, 10).rightSpaceToView(view, 10).topSpaceToView(aliAccount,0).heightIs(1.0);
    
    UILabel *name1 = [[UILabel alloc]init];
    [view addSubview:name1];
    name1.text = @"提现金额";
    name1.textColor = [UIColor grayColor];
    name1.textAlignment = NSTextAlignmentLeft;
    name1.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    name1.sd_layout.leftSpaceToView(view, 10).topSpaceToView(line, 0).heightRatioToView(view, 0.5).widthIs(120);
    
    UILabel *my = [[UILabel alloc]init];
    [view addSubview:my];
    my.textColor = [UIColor grayColor];
    my.textAlignment = NSTextAlignmentRight;
    my.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    my.sd_layout.rightSpaceToView(view, 10).topSpaceToView(line, 0).heightRatioToView(view, 0.5).widthIs(200);
    my.text = self.money;

    
    
    
    depositBtn = [YJDIYButton buttonWithtitle:@"完成" Block:^{
        
        UIViewController *vc = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:vc animated:YES];
        
    }];
    [self.view addSubview:depositBtn];
    depositBtn.sd_layout.leftSpaceToView(self.view, 20).rightSpaceToView(self.view, 20).topSpaceToView(view, 30).heightIs(50);
    depositBtn.backgroundColor = TextColor;
    [depositBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    depositBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    depositBtn.layer.masksToBounds = YES;
    depositBtn.layer.cornerRadius = 5;
    depositBtn.layer.borderColor = BackGray.CGColor;
    depositBtn.layer.borderWidth = 1.0;
    
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
