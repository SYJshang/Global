//
//  YJTextViewController.m
//  全球向导
//
//  Created by SYJ on 2016/11/15.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTextViewController.h"
#import "YJSendOrderController.h"
#import "UITextView+YLTextView.h"

@interface YJTextViewController ()


@end

@implementation YJTextViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

    
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    

    
   UIBarButtonItem *right = [UIBarButtonItem itemWithTarget:self action:@selector(finshBack) title:@"完成" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.rightBarButtonItem = right;

}

- (void)finshBack{
    
    if (self.textView.text != nil && ![self.textView.text isEqualToString:@""]) {
        if (self.block) {
            self.block(self.textView.text);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)back{

    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGray;
    self.title = @"附加内容";
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(1, 0, screen_width - 2, 300)];
    [self.view addSubview:self.textView];
    self.textView.placeholder = @"请输入附加内容";
    self.textView.limitLength = @300;
    self.textView.font = [UIFont systemFontOfSize:15.0];
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 1.0;
    self.textView.textColor = [UIColor colorWithRed:70.0 / 255.0 green:70.0 / 255.0 blue:70.0 / 255.0 alpha:1.0];
    


    
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
