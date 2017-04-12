
//
//  YJTravelController.m
//  全球向导
//
//  Created by SYJ on 2016/12/2.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTravelController.h"
#import "YJLoginFirstController.h"
#import <WebKit/WebKit.h>




@interface YJTravelController ()<WKNavigationDelegate,WKUIDelegate>{
    
    WKWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}

@end

@implementation YJTravelController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"发布" font:19.0];
    
    // 禁用 iOS7 返回手势

}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    

    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 0)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.navigationDelegate = self;
//    webView.UIDelegate = self;
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    [webView setOpaque:NO];//opaque是不透明的意思
//    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.test.com"]];
//    [request addValue:[self readCurrentCookieWithDomain:@"http://www.test.com/"] forHTTPHeaderField:@"Cookie"];
//    [mainWebView loadRequest:request];
//    
    //1.创建并加载远程网页
    if ([self.state isEqualToString:@"1"]) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/userInfo/myUserRec/toAdd",BaseUrl]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        [request addValue:[self readCurrentCookieWithDomain:@"http://www.globaleguide.com:8082/user/getCurrentUserInfo"] forHTTPHeaderField:@"Cookie"];
        [webView loadRequest:request];
        
    }else{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/guide/guideRec/toAdd",BaseUrl]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        [request addValue:[self readCurrentCookieWithDomain:@"http://www.globaleguide.com:8082/user/getCurrentUserInfo"] forHTTPHeaderField:@"Cookie"];
        [webView loadRequest:request];
        
    }
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
}

- (NSString *)readCurrentCookieWithDomain:(NSString *)domainStr{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString * cookieString = [[NSMutableString alloc]init];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
    }
    
    //删除最后一个“；”
    [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    return cookieString;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
}
// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    
//    NSString *requestString = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    NSLog(@"%@",requestString);
//    
//    decisionHandler(WKNavigationResponsePolicyAllow);
//
//        if ([requestString containsString:@"http://www.globaleguide.com"]){
//    
//            [self.navigationController setNavigationBarHidden:NO animated:NO];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//    
//        }else if ([requestString containsString:@"http://globaleguide.com:8082/user/login"]){
//            
//            XXLog(@"退出登录");
//    
//            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未登录" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//    
//                [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
//    
//            }];
//            alert.sure_btnTitleColor = TextColor;
//            [alert show];
//        }else{
//            
//            
//        }
//
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSString *requestString = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",requestString);
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
    if ([requestString containsString:@"http://www.globaleguide.com"]){
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else if ([requestString containsString:@"http://globaleguide.com:8082/user/login"]){
        
        XXLog(@"退出登录");
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未登录" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
            
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
    }else{
        
        
    }
    
}

// 在发送请求之前，决定是否跳转
#pragma mark - WKUIDelegate
//// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//    return [[WKWebView alloc]init];
//}
//// 输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
//    completionHandler(@"http");
//}
//// 确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
//    completionHandler(YES);
//}
//// 警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    NSLog(@"%@",message);
//    completionHandler();
//}
//





//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
//        webView.navigationDelegate = self;
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




@end
