//
//  YJOrderStateController.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOrderStateController.h"
#import <WebKit/WebKit.h>




@interface YJOrderStateController ()<WKNavigationDelegate>{
    WKWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}



@end

@implementation YJOrderStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        NSLog(@"%@", cookie);
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie]; // 保存
    }
    
//    // 定义 cookie 要设定的 host
//    NSURL *cookieHost = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mainApp/list",BaseUrl]];
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"%@", cookie);
//    }
//    
//    // 设定 cookie
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
//                            [NSDictionary dictionaryWithObjectsAndKeys:
//                             [cookieHost host], NSHTTPCookieDomain,
//                             [cookieHost path], NSHTTPCookiePath,
//                             @"token",  NSHTTPCookieName,
//                             @"3f84681-fe38-46a3-ad57-7a266d329ad8", NSHTTPCookieValue,
//                             nil]];
//    
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //加载网页的方式
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/userInfo/myOrder/viewOrderStatusPage/%@",BaseUrl,self.orderID]];
    
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 40, screen_width, screen_height)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.navigationDelegate = self;
    [webView setOpaque:NO];//opaque是不透明的意思
    //    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    //1.创建并加载远程网页
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, screen_width, screen_height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
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
