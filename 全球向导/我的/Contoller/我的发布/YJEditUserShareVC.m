//
//  YJEditUserShareVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/11.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJEditUserShareVC.h"
#import "YJLoginFirstController.h"

@interface YJEditUserShareVC ()<UIWebViewDelegate>{
    UIWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}


@end

@implementation YJEditUserShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 0)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.delegate = self;
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    [webView setOpaque:NO];//opaque是不透明的意思
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    //1.创建并加载远程网页
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/userInfo/myUserRec/toUpdate/%@",BaseUrl,self.ID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * requestString = request.URL.absoluteString;
    if ([requestString isEqualToString:@"http://www.globaleguide.com/"]){
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else if ([requestString isEqualToString:@"http://www.globaleguide.com:8080/user/login"]){
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未登录" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
            
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
    }
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
    
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    
}


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
