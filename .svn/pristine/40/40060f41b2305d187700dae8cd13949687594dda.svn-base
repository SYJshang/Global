//
//  YJSetUpController.m
//  全球向导
//
//  Created by SYJ on 2016/12/5.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSetUpController.h"
#import "YJTimeCell.h"
#import "YJCache.h"
#import "YJAboutUsController.h"
#import "YJAmendPasswordVC.h"
#import "YJLoginFirstController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface YJSetUpController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJSetUpController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"设置" font:19.0];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    self.tableView.backgroundColor = BackGray;
    
    [self.tableView registerClass:[YJTimeCell class] forCellReuseIdentifier:@"first"];
    
    // Do any additional setup after loading the view.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - table view dataSource

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    
    if (section == 1) {
        return 2;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        //获取版本信息
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
        //获取缓存
        float cache = [YJCache filePath];
        NSString *str = [NSString stringWithFormat:@"%.2f Mb",cache];
        
        switch (indexPath.row) {
            case 0:
//                NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//                NSLog(@"%@",infoDic);
//                NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];

               cell.title.text = @"当前版本";
                cell.time.text = currentVersion;
                break;
            case 1:
                cell.title.text = @"清空缓存";
                cell.time.text = str;
                break;
            case 2:
                cell.title.text = @"修改密码";
                cell.time.text = @"";
                break;
                
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"意见反馈";
                cell.time.text = @"";
                break;
            case 1:
                cell.title.text = @"关于我们";
                cell.time.text = @"";
                break;
                
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *code = [userDefault objectForKey:@"code"];
        if ([code isEqualToString:@"1"]) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell addSubview:btn];
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = TextColor;
            btn.frame = CGRectMake(20, 5, screen_width - 40, 40);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 10;
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = BackGray.CGColor;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackGray;
        return cell;
    }
    
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    
    return cell;
}

- (void)quit{
    
    //清空保存的数据
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"code"];
    
    //退出
    [self removeCookie];
    //服务器退出
    [self logOut];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.color = [UIColor blackColor];
    hud.label.text = NSLocalizedString(@"退出成功!", @"HUD message title");
    [hud hideAnimated:YES afterDelay:3.f];
 
    
    [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
    
    
    XXLog(@"退出");
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //清空缓存
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Set the determinate mode to show task progress.
//        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = NSLocalizedString(@"正在清理...", @"HUD loading title");
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            // Do something useful in the background and update the HUD periodically.
            sleep(2.);
            [YJCache clearFile];
            
            dispatch_async(dispatch_get_main_queue(), ^{
           
            UIImage *image = [[UIImage imageNamed:@"smile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hud.customView = imageView;
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.text = NSLocalizedString(@"完成", @"HUD completed title");
           
            });
            
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                

            });
            
        });


}
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        [self.navigationController pushViewController:[YJAmendPasswordVC new] animated:YES];
        
}

    
    //意见反馈
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"意见反馈" message:@"请给我们提供意见" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){

        [XRZNotificationCenter addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            XXLog(@"输入的反馈意见为 %@",textField.text);
            
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [YJCache clearFile];
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self.navigationController pushViewController:[YJAboutUsController new] animated:YES];
    }
    
    
}


- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        XXLog(@"%@",login.text);
    }
}

//退出
- (void)logOut{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code = [userDefault objectForKey:@"code"];
    if ([code isEqualToString:@"1"]) {
        
        [WBHttpTool GET:[NSString stringWithFormat:@"%@/user/logout2",BaseUrl] parameters:nil success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict);
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        
        XXLog(@"退出失败");
        
    }
    
}

- (void)removeCookie{
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    XXLog(@"%@",cookieJar);

}


- (void)saveCookie{
    
    
    //第一步
    //    NSHTTPCookieStorage *myCookie = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //    for (NSHTTPCookie *cookie in [myCookie cookies]) {
    //        NSLog(@"%@", cookie);
    //        //需要将cookie保存下来，以便自动登录
    //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie]; //保存
    //
    //    }
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //    将其保存再本地
    //把cookie进行归档并转换为NSData类型
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    //存储归档后的cookie
    NSUserDefaults*userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: cookiesData forKey: @"cookie"];
    
    
    
    
    //    第二步 开启后  预先增加到缓存里
    
    //设置cookie缓存
    
    //寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
//    NSArray *cooki = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:BaseUrl]]; //这里的HOST是你web服务器的域名地址
    NSArray *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    //    DLog(@"cookies:%d",cookies.count);
    //    DLog(@"cookies:%@",cookies);
    // 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com
    
    //设置header，通过遍历cookies来一个一个的设置header
    for (NSHTTPCookie *cook in cookie){
        
        // cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
        NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
                                    [NSDictionary dictionaryWithObject:
                                     [[NSString alloc] initWithFormat:@"%@=%@",[cook name],[cook value]]
                                                                forKey:@"Set-Cookie"]
                                                                          forURL:[NSURL URLWithString:BaseUrl]];
        //通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
                                                           forURL:[NSURL URLWithString:BaseUrl]
                                                  mainDocumentURL:nil];
    }
    
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
