//
//  YJReplaceNameVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/3.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJReplaceNameVC.h"

#define MAX_STARWORDS_LENGTH 20

@interface YJReplaceNameVC ()

@property (nonatomic, strong) UITextField *userNickTf;


@end

@implementation YJReplaceNameVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = BackGray;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"完成" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"创建相册" font:19.0];
}

- (void)finsh{
    if (self.userNickTf.text.length > 0 && self.userNickTf.text != nil) {
        [self getNetWork];
    }
}

- (void)back{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNickTf = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, screen_width - 20, 40)];
    [self.view addSubview:self.userNickTf];
    self.userNickTf.borderStyle = UITextBorderStyleRoundedRect;
    self.userNickTf.layer.masksToBounds = YES;
    self.userNickTf.layer.cornerRadius = 5;
    self.userNickTf.layer.borderColor = TextColor.CGColor;
    self.userNickTf.layer.borderWidth = 1.0;
    self.userNickTf.placeholder = @"输入相册名称";
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.userNickTf];
    
    
    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.userNickTf.text forKey:@"name"];
    [parameter setObject:self.albumId forKey:@"id"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/album/update",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            //            self.albumID = dict[@"data"][@"id"];
            
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"修改名称成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];
            
            UIViewController *vc = self.navigationController.viewControllers[2];
            [self.navigationController popToViewController:vc animated:YES];
            
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户长度不能超过20" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:action1];
            [alertVC addAction:action2];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                XXLog(@"%@",textField.text);
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
                XXLog(@"%@",textField.text);
                
            }
        }
    }
    
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
