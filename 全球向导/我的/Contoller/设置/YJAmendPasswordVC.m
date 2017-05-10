//
//  YJAmendPasswordVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/26.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAmendPasswordVC.h"
#import "WBHttpTool.h"
#import "MobileNumberHelper.h"
#import "YJLoginFirstController.h"

@interface YJAmendPasswordVC ()

@property (nonatomic, strong) UILabel *pwdOld;
@property (nonatomic, strong) UILabel *pwdNew;
@property (nonatomic, strong) UITextField *pwdTfOld;
@property (nonatomic, strong) UITextField *pwdTfNew;

@property (nonatomic, strong) UIButton *amendBtn;

@end

@implementation YJAmendPasswordVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightBarBtn) title:@"保存" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"修改密码" font:19.0];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBarBtn{

    //保存
    [self clcik];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setViews];
    
    // Do any additional setup after loading the view.
}

- (void)setViews{
    
    self.pwdOld = [[UILabel alloc]init];
    [self.view addSubview:self.pwdOld];
    self.pwdOld.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    self.pwdOld.text = YJLocalizedString(@"旧密码");
    self.pwdOld.textColor = [UIColor blackColor];
    self.pwdOld.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.view,124).heightIs(30 * KHeight_Scale).widthIs(60 * KWidth_Scale);
    
    self.pwdTfOld = [[UITextField alloc]init];
    self.pwdTfOld.textColor = [UIColor blackColor];
    [self.view addSubview:self.pwdTfOld];
    self.pwdTfOld.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.pwdTfOld.borderStyle = UITextBorderStyleNone;
    self.pwdTfOld.placeholder = YJLocalizedString(@"请输入旧密码");
    self.pwdTfOld.secureTextEntry = YES;
    self.pwdTfOld.sd_layout.leftSpaceToView(self.pwdOld,5).rightSpaceToView(self.view,20).centerYEqualToView(self.pwdOld).heightIs(30 * KHeight_Scale);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = BackGroundColor;
    [self.view addSubview:line];
    line.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).topSpaceToView(self.pwdOld,5).heightIs(1);
    
    
    self.pwdNew = [[UILabel alloc]init];
    [self.view addSubview:self.pwdNew];
    self.pwdNew.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    self.pwdNew.text = YJLocalizedString(@"新密码");
    self.pwdNew.textColor = [UIColor blackColor];
    self.pwdNew.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line,20).heightIs(30 * KHeight_Scale).widthIs(60 * KWidth_Scale);
    
    self.pwdTfNew = [[UITextField alloc]init];
    self.pwdTfNew.textColor = [UIColor blackColor];
    [self.view addSubview:self.pwdTfNew];
    self.pwdTfNew.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.pwdTfNew.borderStyle = UITextBorderStyleNone;
    self.pwdTfNew.placeholder = YJLocalizedString(@"请输入新密码");
    self.pwdTfNew.secureTextEntry = YES;
    self.pwdTfNew.sd_layout.leftSpaceToView(self.pwdNew,5).rightSpaceToView(self.view,20).centerYEqualToView(self.pwdNew).heightIs(30 * KHeight_Scale);
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = BackGroundColor;
    [self.view addSubview:line1];
    line1.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).topSpaceToView(self.pwdNew,5).heightIs(1);
    
    self.amendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.amendBtn];
    [self.amendBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.amendBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [self.amendBtn setBackgroundColor:[UIColor whiteColor]];
    self.amendBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(20)];
    [self.amendBtn addTarget:self action:@selector(clcik) forControlEvents:UIControlEventTouchUpInside];
    self.amendBtn.sd_layout.leftSpaceToView(self.view,40).rightSpaceToView(self.view,40).heightIs(40 * KHeight_Scale).topSpaceToView(line1,50 * KHeight_Scale);
    self.amendBtn.layer.masksToBounds = YES;
    self.amendBtn.layer.cornerRadius = 15.0;
    self.amendBtn.layer.borderColor = TextColor.CGColor;
    self.amendBtn.layer.borderWidth = 1.0;
    
    
}

- (void)clcik{
    
    if ([MobileNumberHelper isValidPassword:self.pwdTfNew.text] && [MobileNumberHelper isValidPassword:self.pwdTfOld.text]) {
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:self.pwdTfOld.text forKey:@"oldLoginPwd"];
        [parameter setObject:self.pwdTfNew.text forKey:@"newLoginPwd"];
        
        [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/accountSafe/updateLoginPwd",BaseUrl] parameters:parameter success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict);
            
            if ([dict[@"code"] isEqualToString:@"1"]) {

                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更改密码完成，是否重新登录" preferredStyle:UIAlertControllerStyleAlert];
                
                
                //修改title
                
                NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
                
                [alertControllerStr addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0, alertControllerStr.length)];
                
                [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AdaptedWidth(19)] range:NSMakeRange(0, alertControllerStr.length)];
                
                [alert setValue:alertControllerStr forKey:@"attributedTitle"];
                
                //修改message
                
                NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"更改密码完成，是否重新登录" ];
                
                [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
                
                [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AdaptedWidth(15)] range:NSMakeRange(0, alertControllerMessageStr.length)];
                
                [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
                
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
//                    [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
                    [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

                    
                }];
                [action setValue:TextColor forKey:@"titleTextColor"];
                
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    //
                }];
                [action1 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
                
                
                
                [alert addAction:action];
                [alert addAction:action1];
                
                [self presentViewController:alert animated:YES completion:nil];

                
            }else if ([dict[@"code"] isEqualToString:@"2"]){
                
                SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                    [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                    [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

                }];
                alertV.sure_btnTitleColor = TextColor;
                [alertV show];
                
            }else{
               [self title:@"提示" message:dict[@"msg "] titleColor:TextColor messageColor:[UIColor grayColor] leftBtnColor:TextColor rightColor:[UIColor grayColor]];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        
        [self title:@"提示" message:@"密码格式有错" titleColor:TextColor messageColor:[UIColor grayColor] leftBtnColor:TextColor rightColor:[UIColor grayColor]];
        
    }
    
}

- (void)title:(NSString *)title message:(NSString *)message titleColor:(UIColor *)titleColor messageColor:(UIColor *)messageColor leftBtnColor:(UIColor *)leftBtnColor rightColor:(UIColor *)rightColor{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    //修改title
    
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, alertControllerStr.length)];
    
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AdaptedWidth(19)] range:NSMakeRange(0, alertControllerStr.length)];
    
    [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    
    //修改message
    
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
    
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AdaptedWidth(15)] range:NSMakeRange(0, alertControllerMessageStr.length)];
    
    [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action setValue:leftBtnColor forKey:@"titleTextColor"];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [action1 setValue:rightColor forKey:@"titleTextColor"];
    
    
    
    [alert addAction:action];
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
