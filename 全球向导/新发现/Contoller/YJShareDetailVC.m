
//
//  YJShareDetailVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJShareDetailVC.h"

@interface YJShareDetailVC ()<UIWebViewDelegate>{
    UIWebView *webView;
    
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
    self.automaticallyAdjustsScrollViewInsets = YES;

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
    
    
    
    
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"用户分享") font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)share:(UIButton *)btn{
    
    XXLog(@"分享");
    
}

- (void)showBottomCircleView
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
#ifdef UM_Swift
    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
            [self shareWebPageToPlatformType:platformType];
        }];
    }
     
 - (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"全球向导分享" descr:@"欢迎查看全球向导分享内容" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@/mainGuideRec/toViewPage/%@",BaseUrl,self.ID];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
    }
         
     - (void)alertWithError:(NSError *)error
    {
        NSString *result = nil;
        if (!error) {
            result = [NSString stringWithFormat:@"Share succeed"];
        }
        else{
            NSMutableString *str = [NSMutableString string];
            if (error.userInfo) {
                for (NSString *key in error.userInfo) {
                    [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
                }
            }
            if (error) {
                result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
            }
            else{
                result = [NSString stringWithFormat:@"Share fail"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:result
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                              otherButtonTitles:nil];
        [alert show];
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
                hud.labelColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.labelText = NSLocalizedString(@"收藏成功", @"HUD message title");
                [hud hide:YES afterDelay:2.0];

                
                
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
                hud.labelColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.labelText = NSLocalizedString(@"取消收藏成功！", @"HUD message title");
                [hud hide:YES afterDelay:2.0];

                
                
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
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webView.delegate = self;
    [webView setOpaque:NO];//opaque是不透明的意思
        [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mainUserRec/toViewPage/%@",BaseUrl,self.ID]];
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

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
}



//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
        webView.delegate = self;
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
