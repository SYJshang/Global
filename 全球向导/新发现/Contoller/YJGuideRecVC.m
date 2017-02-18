
//
//  YJGuideRecVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGuideRecVC.h"
#import <WebKit/WebKit.h>


@interface YJGuideRecVC ()<WKNavigationDelegate>{
    WKWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}


@end

@implementation YJGuideRecVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = BackGray;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"coliectionNoraml"] style:UIBarButtonItemStylePlain target:self action:@selector(collect)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 10, 22, 22);
    [btn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"向导类型" font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)collect:(UIButton *)btn{

    
    [btn setImage:[UIImage imageNamed:@"collect-select"] forState:UIControlStateNormal];

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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.128:8080/web/mainGuideRec/toViewPage/%@",self.ID]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
       
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    

    
    // Do any additional setup after loading the view.
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
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
