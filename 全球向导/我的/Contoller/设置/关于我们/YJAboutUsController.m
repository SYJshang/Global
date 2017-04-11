//
//  YJAboutUsController.m
//  全球向导
//
//  Created by SYJ on 2016/12/6.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAboutUsController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YJMineController.h"

@interface YJAboutUsController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *opaqueView;

@end

@implementation YJAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.titleView= [UILabel titleWithColor:[UIColor blackColor] title:@"关于我们" font:19.0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height)];
    self.webView.delegate = self;
//    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil];
        NSURL *htmlURL = [NSURL URLWithString:@"http://192.168.1.128/%E7%A7%BB%E5%8A%A8%E7%AB%AFwechat%E9%A1%B5%E9%9D%A2/wechat/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    [self.webView setUserInteractionEnabled:YES];//是否支持交互
    [self.webView setScalesPageToFit:YES];
    self.webView.backgroundColor = [UIColor clearColor];
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longPressed.delegate = self;
    [self.webView addGestureRecognizer:longPressed];

    #pragma mark - sss
    
    self.opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height)];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.activityIndicatorView setCenter:self.opaqueView.center];
    [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.opaqueView setBackgroundColor:[UIColor blackColor]];
    [self.opaqueView setAlpha:0.6];
    [self.view addSubview:self.opaqueView];
    [self.opaqueView addSubview:self.activityIndicatorView];

    
    // Do any additional setup after loading the view.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)longPressed:(UITapGestureRecognizer*)recognizer{
    //只在长按手势开始的时候才去获取图片的url
    if (recognizer.state != UIGestureRecognizerStateBegan){
        return;
    }
    CGPoint touchPoint = [recognizer locationInView:self.webView];
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:js];
    if (urlToSave.length == 0) {
        return;
    }
    NSLog(@"获取到图片地址：%@",urlToSave);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - webView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicatorView startAnimating];
    self.opaqueView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicatorView stopAnimating];
    self.opaqueView.hidden = YES;

    XXLog(@"完成加载");
    [self pushNext];
    
}

- (void)pushNext{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context evaluateScript:@"1"];
    [self addScanWithContext:context];
    
}

- (void)addScanWithContext:(JSContext *)context
{
    XXLog(@"123455");
    context[@"mui-pull-right custom_add"] = ^() {

//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"测试" message:@"这是点击HTML的按钮" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
       
        
        XXLog(@"....");
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//     Dispose of any resources that can be recreated.
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
