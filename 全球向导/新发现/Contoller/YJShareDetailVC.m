
//
//  YJShareDetailVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJShareDetailVC.h"
#import <WebKit/WebKit.h>

@interface YJShareDetailVC ()<WKNavigationDelegate>{
    WKWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
    UIButton *colBtn;
    UIButton *share;
}


@end

@implementation YJShareDetailVC


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBar.barTintColor = BackGray;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
   
    colBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [colBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [colBtn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
    colBtn.selected = NO;
    [colBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:colBtn];
    
    share = [UIButton buttonWithType:UIButtonTypeCustom];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [share setImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"share"] forState:UIControlStateHighlighted];
    share.selected = NO;
    [share sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,settingBtnItem];
    
    
    
    
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"向导类型" font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)share:(UIButton *)btn{
    
    XXLog(@"分享");
    
}

- (void)collect:(UIButton *)btn{
    
    if (btn.selected == NO) {
        //点击收藏
        NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
        [parmeter setObject:self.ID forKey:@"recId"];
        XXLog(@"%@",self.ID);
        
        [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myColUserRec/add",BaseUrl] parameters:parmeter success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict[@"code"]);
            XXLog(@"%@",dict);
            if ([dict[@"code"] isEqualToString:@"1"]) {
                
                [btn setImage:[UIImage imageNamed:@"collect-select"] forState:UIControlStateNormal];
                [btn setTitleColor:TextColor forState:UIControlStateNormal];
                btn.selected = YES;
                
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.contentColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.label.text = NSLocalizedString(@"收藏成功!", @"HUD message title");
                [hud hideAnimated:YES afterDelay:2.f];
                
                
            }else{
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }else{
        
        //点击取消收藏
        NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
        [parmeter setObject:self.ID forKey:@"recId"];
        XXLog(@"%@",self.ID);
        [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myColUserRec/cancelByRecId",BaseUrl] parameters:parmeter success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict[@"code"]);
            XXLog(@"%@",dict);
            if ([dict[@"code"] isEqualToString:@"1"]) {
                
                [btn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.selected = NO;
                
                
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.contentColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.label.text = NSLocalizedString(@"取消收藏成功!", @"HUD message title");
                [hud hideAnimated:YES afterDelay:2.f];
                
                
            }else{
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    // Do any additional setup after loading the view.
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.navigationDelegate = self;
    [webView setOpaque:NO];//opaque是不透明的意思
    //    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.128:8080/web/mainUserRec/toViewPage/%@",self.ID]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
    
    [self getNetWork];
    
    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainUserRec/toView/%@",BaseUrl,self.ID] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            
            NSString *col = [NSString stringWithFormat:@"%@",dict[@"data"][@"isCol"]];
            XXLog(@"收藏状态%@",col);
            
            if ([col isEqualToString:@"0"]) {
                
                [colBtn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
                colBtn.selected = NO;
                
            }else{
                [colBtn setImage:[UIImage imageNamed:@"collect-select"] forState:UIControlStateNormal];
                colBtn.selected = YES;
            }
            
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    XXLog(@"error code ==  %ld",error.code);
    if (error.code  == -999) {
        return;
    }
    
}

//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
        webView.navigationDelegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        
        if ([error code] == 404) {
            webView.hidden = YES;
        }
        
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
