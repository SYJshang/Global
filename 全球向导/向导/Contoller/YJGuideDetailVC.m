//
//  YJGuideDetailVC.m
//  全球向导
//
//  Created by SYJ on 2017/1/12.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGuideDetailVC.h"
#import "YJGuideIntroCell.h"
#import "YJGuiServerCell.h"
#import "YJOtherServerCell.h"
#import "YJCommentCell.h"
#import "YJOrderFormController.h"
#import "YJGuideModel.h"
#import "YJServerModel.h"
#import "YJEvaModel.h"
#import "YJLoginFirstController.h"
#import "YJAllEveVC.h"
#import "YJUserGuideCenterVC.h"
#import "YJChatVC.h"


@interface YJGuideDetailVC ()<UITableViewDelegate,UITableViewDataSource,IntroDetailDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bigImg; //大的背景图片
@property (nonatomic, strong) UIImageView *topView;//头部图片
@property (nonatomic, strong) UILabel *name;//名称
@property (nonatomic, strong) UILabel *GuideType;//向导类型
@property (nonatomic, strong) YJDIYButton *shareBtn;//分享按钮
@property (nonatomic, strong) YJDIYButton *collectBtn;//收藏按钮

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) YJGuideModel *guideModel;//向导model
@property (nonatomic, strong) NSMutableArray *serverListArr;//向导服务类型列表
@property (nonatomic, strong) NSMutableArray *evaListArr;//评论

@property (nonatomic, assign) int isCol; //是否收藏


@end

@implementation YJGuideDetailVC

- (NSMutableArray *)serverListArr{
    
    if (_serverListArr == nil) {
        _serverListArr = [NSMutableArray array];
    }
    
    return _serverListArr;
}

- (NSMutableArray *)evaListArr{
    
    if (_evaListArr == nil) {
        _evaListArr = [NSMutableArray array];
    }
    
    return _evaListArr;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.isOpen = YES;
    
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"向导类型") font:19.0];

    [self setBtn];
    //添加tableView
    [self setTableView];
    [self getNetWork];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGray;
    [self getNetWork];
    // Do any additional setup after loading the view.
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setBtn{
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, screen_height - 44, screen_width, 1);
    view.backgroundColor = BackGray;
    
    
    
    
    YJButton *guide_home = [[YJButton alloc]initWithFrame:CGRectMake(0, screen_height - 44, screen_width / 4, 43)];
    [self.view addSubview:guide_home];
    [guide_home setBackgroundColor:[UIColor whiteColor]];
    [guide_home setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [guide_home setTitle:YJLocalizedString(@"向导主页") forState:UIControlStateNormal];
    [guide_home setImage:[UIImage imageNamed:@"guide_home"] forState:UIControlStateNormal];
    [guide_home addTarget:self action:@selector(mainList) forControlEvents:UIControlEventTouchUpInside];
    
    
    YJButton *contact_guide = [[YJButton alloc]initWithFrame:CGRectMake(screen_width / 4, screen_height - 44, screen_width / 4, 43)];
    [self.view addSubview:contact_guide];
    [contact_guide setBackgroundColor:[UIColor whiteColor]];
    [contact_guide setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [contact_guide setTitle:YJLocalizedString(@"联系向导") forState:UIControlStateNormal];
    [contact_guide setImage:[UIImage imageNamed:@"contact_guide"] forState:UIControlStateNormal];
    [contact_guide addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buy];
    buy.frame = CGRectMake(screen_width / 2, screen_height - 44, screen_width - screen_width / 2, 43);
    buy.backgroundColor = TextColor;
    [buy setTitle:YJLocalizedString(@"付款") forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)call{
    
    
    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([code isEqualToString:@"1"]) {
        YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:self.guideModel.userId conversationType:EMConversationTypeChat];
        vc.title = self.guideModel.realName;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未登录！是否现在登录？" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
            
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];

        
    }
    
   
}


- (void)action:(YJButton *)btn{
    
    NSString *code = [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
    if ([code isEqualToString:@"1"]) {
        
        YJOrderFormController *vc = [[YJOrderFormController alloc]init];
        vc.guideID = self.guideId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未登录！是否现在登录？" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
        
        
    }
    
    
   
    
}

- (void)mainList{
    
    YJUserGuideCenterVC *vc = [[YJUserGuideCenterVC alloc]init];
    vc.ID = self.guideId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 108) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];


    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(200 * KHeight_Scale, 0, 0, 0);
    
    [self.tableView registerClass:[YJGuideIntroCell class] forCellReuseIdentifier:@"intro"];
    [self.tableView registerClass:[YJGuiServerCell class] forCellReuseIdentifier:@"server"];
    [self.tableView registerClass:[YJOtherServerCell class] forCellReuseIdentifier:@"otherServer"];
    [self.tableView registerClass:[YJCommentCell class] forCellReuseIdentifier:@"comment"];

    [self setImage];
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下的话 为负数
    CGFloat off_y = scrollView.contentOffset.y;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    // 下拉超过照片的高度的时候
    XXLog(@"%f",off_y);
    if (off_y < -200)
    {
        CGRect frame = self.bigImg.frame;
        // 这里的思路就是改变 顶部的照片的 frame
        self.bigImg.frame = CGRectMake(0, off_y, frame.size.width, -off_y);
    }
    
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake( - scrollView.contentOffset.y + 200, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
            [self shareImageAndTextToPlatformType:platformType];
        }];
    }
     
     //分享图片和文字
     - (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
    {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString * thumbURL =  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D360/sign=8e6787f779899e51678e3c1272a6d990/e824b899a9014c08d59b7caf087b02087bf4f41c.jpg";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享test" descr:@"这是一个分享内容，就是看看能不能分享出去" thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = @"http://www.globaleguide.com";
        
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
         
 - (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
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



- (void)setImage{
    
    self.bigImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -200, screen_width, 200))];
    self.bigImg.image = [UIImage imageNamed:@"bg2"];
    self.bigImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bigImg.clipsToBounds = YES;
    self.bigImg.userInteractionEnabled = YES;
    [self.tableView addSubview:self.bigImg];
    
    
    self.topView = [[UIImageView alloc]init];
//    [self.topView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
    self.topView.image = [UIImage imageNamed:@"HeaderIcon"];
    [self.bigImg addSubview:self.topView];
    self.topView.sd_layout.centerXEqualToView(self.bigImg).centerYEqualToView(self.bigImg).heightIs(75 * KWidth_Scale).widthIs(75 * KWidth_Scale);
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.cornerRadius = self.topView.width / 2;
    self.topView.layer.borderColor = BackGray.CGColor;
    self.topView.layer.borderWidth = 1.0;
    self.topView.userInteractionEnabled = YES;
    
    //名称
    self.name = [[UILabel alloc]init];
    [self.bigImg addSubview:self.name];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = [UIFont systemFontOfSize:AdaptedWidth(12.0)];
    self.name.textColor = [UIColor whiteColor];
    self.name.text = @"啊啊啊啊啊啊啊";
    self.name.sd_layout.topSpaceToView(self.topView,10).centerXEqualToView(self.topView).heightIs(15 * KHeight_Scale).widthIs(150 *KWidth_Scale);
    
    //向导类型
    self.GuideType = [[UILabel alloc]init];
    [self.bigImg addSubview:self.GuideType];
    self.GuideType.textAlignment = NSTextAlignmentCenter;
    self.GuideType.font = [UIFont systemFontOfSize:AdaptedWidth(12.0)];
    self.GuideType.textColor = [UIColor whiteColor];
    self.GuideType.text = @"啊啊啊啊啊啊啊";
    self.GuideType.sd_layout.topSpaceToView(self.name,5).centerXEqualToView(self.topView).heightIs(15 * KHeight_Scale).widthIs(150 *KWidth_Scale);
    
    //分享
    self.shareBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) title:@"分享" imageName:@"share" Block:^{
        
        [self showBottomCircleView];
        
    }];
    [self.shareBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, 25, -5, 0)];
    [self.shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 10)];
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(12.0)];
    [self.bigImg addSubview:self.shareBtn];
    self.shareBtn.sd_layout.bottomSpaceToView(self.bigImg,10).leftSpaceToView(self.bigImg,50 * KWidth_Scale).heightIs(20).widthIs(40);
    
    
    //收藏
    self.collectBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) title:YJLocalizedString(@"收藏") imageName:@"coliectionNoraml" Block:^{
        if (self.collectBtn.selected == NO) {
            //点击收藏
            NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
            [parmeter setObject:self.guideId forKey:@"guideId"];
            XXLog(@"%@",self.guideId);

            [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myColGuide/add",BaseUrl] parameters:parmeter success:^(id responseObject) {
                
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict[@"code"]);
            XXLog(@"%@",dict);
            if ([dict[@"code"] isEqualToString:@"1"]) {
                
                [self.collectBtn setImage:[UIImage imageNamed:@"collect-select"] forState:UIControlStateNormal];
                [self.collectBtn setTitleColor:TextColor forState:UIControlStateNormal];
                self.collectBtn.selected = YES;

                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.labelText = NSLocalizedString(@"收藏成功!", @"HUD message title");
                [hud hide:YES afterDelay:2.0];

                
            }else if ([dict[@"code"] isEqualToString:@"10096"]){
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"不能收藏自己！" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];
            }else if ([dict[@"code"] isEqualToString:@"10086"]){
                
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"你已经收藏过该向导！" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];

            }else{
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"收藏失败！请重新登录过后重试！" alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    if (index == 1) {
                        [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
                    }
                }];
                alert.sure_btnTitleColor = TextColor;
                alert.sure_btnTitle = @"去登录";
                [alert show];
            }

                
            } failure:^(NSError *error) {
                
            }];
            

 
        }else{
            
            //点击取消收藏
            NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
            [parmeter setObject:self.guideId forKey:@"guideId"];
            XXLog(@"%@",self.guideId);
            [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myColGuide/cancelByGuideId",BaseUrl] parameters:parmeter success:^(id responseObject) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                XXLog(@"%@",dict[@"code"]);
                XXLog(@"%@",dict);
                if ([dict[@"code"] isEqualToString:@"1"]) {
                    
                    [self.collectBtn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
                    [self.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self.collectBtn.selected = NO;
                    

                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelColor = [UIColor whiteColor];
                    hud.color = [UIColor blackColor];
                    hud.labelText = NSLocalizedString(@"取消收藏成功!", @"HUD message title");
                    [hud hide:YES afterDelay:2.0];
                    
                }else if ([dict[@"code"] isEqualToString:@"10088"]){
                    SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"该收藏不存在！" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                        
                    }];
                    alert.sure_btnTitleColor = TextColor;
                    [alert show];
                }else if ([dict[@"code"] isEqualToString:@"10089"]){
                    
                    SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"该收藏不属于你，无法取消！" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                        
                    }];
                    alert.sure_btnTitleColor = TextColor;
                    [alert show];
                    
                }else{
                    SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"取消收藏失败！请重新登录过后重试！" alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                        if (index == 1) {
                            [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
                        }
                    }];
                    alert.sure_btnTitleColor = TextColor;
                    alert.sure_btnTitle = @"去登录";
                    [alert show];
                }
                
                
            } failure:^(NSError *error) {
                
            }];

            

        }
    }];
    [self.bigImg addSubview:self.collectBtn];
    [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, 0, -5, 10)];
    [self.collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, -15)];
    self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(12.0)];
    self.collectBtn.sd_layout.bottomSpaceToView(self.bigImg,10).rightSpaceToView(self.bigImg,50 * KWidth_Scale).heightIs(20).widthIs(40);
    
}



- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/toView/%@",BaseUrl,self.guideId] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = dict[@"data"];
            self.guideModel = [YJGuideModel mj_objectWithKeyValues:data[@"guide"]];
            
            [self.bigImg sd_setImageWithURL:[NSURL URLWithString:self.guideModel.coverPhotoUrl] placeholderImage:[UIImage imageNamed:@"bg2"]];
            self.name.text = self.guideModel.realName;
            self.GuideType.text = self.guideModel.guideDesc;
            [self.topView sd_setImageWithURL:[NSURL URLWithString:self.guideModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];

            
            self.serverListArr = [YJServerModel mj_objectArrayWithKeyValuesArray:data[@"productList"]];
            self.evaListArr = [YJEvaModel mj_objectArrayWithKeyValuesArray:data[@"evaFinishList"]];
            NSString *iscol = data[@"isCol"];
            self.isCol = [iscol intValue];
            if (self.isCol == 1) {
                self.collectBtn.selected = YES;
                [self.collectBtn setImage:[UIImage imageNamed:@"collect-select"] forState:UIControlStateNormal];
                [self.collectBtn setTitleColor:TextColor forState:UIControlStateNormal];
                
            }else{
                self.collectBtn.selected = NO;
                [self.collectBtn setImage:[UIImage imageNamed:@"coliectionNoraml"] forState:UIControlStateNormal];
                [self.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            [self.tableView reloadData];
  
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - table view dataSource

 -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
 
 -(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, screen_width - 20, 20)];
//    label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.9];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    if (section == 0) {
        label.text = YJLocalizedString(@"向导简介");
    }else if (section == 1){
        label.text = YJLocalizedString(@"提供服务项");
    }else if (section == 2){
        label.text =YJLocalizedString(@"游客评论");
    }
    [view addSubview:label];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.serverListArr.count;
    }else if (section == 2){
        if (self.evaListArr.count > 0) {
            return 2;
        }
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (self.isOpen == YES) {
            return 80;
        }else{
             return [YJGuideIntroCell cellHegith:self.guideModel];
        }
        
       
    }else if (indexPath.section == 1){
        
        return 70;
    }else if (indexPath.section == 2 && indexPath.row == 0){
        if (self.evaListArr.count > 0) {
            YJEvaModel *model = self.evaListArr[indexPath.row];
            return [YJCommentCell cellHegith:model];
        }

    }
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YJGuideIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"intro"];
        if (self.guideModel.summary) {
            [cell configCellWithText:self.guideModel];
        }
        cell.introLab.text = self.guideModel.summary;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        
//        NSArray *titleArr = @[@"徒步接机",@"带车接机",@"徒步陪游",@"带车陪游",@"徒步送机",@"带车送机"];
//        NSArray *iconArr = @[@"icon3",@"icon4",@"icon5",@"icon6",@"icon7",@"icon8"];
//        NSArray *descArr = @[@"搭乘公交地铁等接机",@"向导专车接机",@"搭乘公交陪游",@"向导专车陪游",@"搭乘公众交通送机",@"向导开车送机"];
        
        YJGuiServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"server"];
        YJServerModel *model = self.serverListArr[indexPath.row];
        cell.model = model;
        
        return cell;
        
    }else if (indexPath.section == 2){
        
        if (self.evaListArr.count > 0) {
            if (indexPath.row == 0 && self.evaListArr.count > 0) {
                YJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
                YJEvaModel *model = self.evaListArr[indexPath.row];
                [cell configCellWithText:model];
                cell.model = model;
                return cell;
            }
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            YJDIYButton *btn = [YJDIYButton buttonWithtitle:@"查看更多评论" Block:^{
                YJAllEveVC *vc = [[YJAllEveVC alloc]init];
                vc.ID = self.guideId;
                [self.navigationController pushViewController:vc animated:YES];
                XXLog(@"查看更多评论");
            }];
            [cell.contentView addSubview:btn];
            btn.sd_layout.centerXEqualToView(cell.contentView).centerYEqualToView(cell.contentView).heightIs(40).widthIs(200);
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 10;
            btn.layer.borderColor = TextColor.CGColor;
            btn.layer.borderWidth = 1;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            YJDIYButton *btn = [YJDIYButton buttonWithtitle:@"暂无评论" Block:^{
                
                XXLog(@"查看更多评论");
            }];
            [cell.contentView addSubview:btn];
            btn.sd_layout.centerXEqualToView(cell.contentView).centerYEqualToView(cell.contentView).heightIs(40).widthIs(200);
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 10;
            btn.layer.borderColor = TextColor.CGColor;
            btn.layer.borderWidth = 1;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
        

        
}
    
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}



#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
}


#pragma mark - delegate

- (void)introDetail:(BOOL)Detail{
    
    self.isOpen = Detail;
    [self.tableView reloadData];
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
