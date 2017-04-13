//
//  YJOrderStateController.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOrderStateController.h"
#import "YJLoginFirstController.h"




@interface YJOrderStateController ()<UIWebViewDelegate>{
    UIWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}



@end

@implementation YJOrderStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
   
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/userInfo/myOrder/viewOrderStatusPage/%@",BaseUrl,self.orderID]];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 108, screen_width, screen_height - 108)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.delegate = self;
    [webView setOpaque:NO];//opaque是不透明的意思
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    //1.创建并加载远程网页
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


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
    
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * requestString = request.URL.absoluteString;
    NSLog(@"请求的地址：%@",requestString);
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
