//
//  YJMineNewVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMineNewVC.h"
#import "YJRegsiterController.h"
#import "YJLoginFirstController.h"
#import "YJCollectController.h"
#import "UIImageView+LBBlurredImage.h"
#import "YJSetUpController.h"
#import "YJMyOrderController.h"
#import "YJGuideCenterController.h"
#import "YJSetUserController.h"
#import "YJMineEvaluateVC.h"
#import "YJUsreInfoModel.h"
#import "YJMineShareVC.h"
#import "UIImageView+WebCache.h"
#import "YJTableCollectionCell.h"
#import "YJRankVC.h"
#import "YJIntegralVC.h"
#import "XWPopMenuController.h"


#define KMargin 0   // 间距
#define KStatusBarHeight 0  // 状态栏高度

@interface YJMineNewVC ()<UITableViewDataSource,UITableViewDelegate,ImgBtnClickDelegte>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nickName; //昵称名称
@property (nonatomic, strong) UILabel *NoLab;
@property (nonatomic, strong) UILabel *rankLab; //等级

@property (nonatomic, strong) NSString *guideStatus;
// 顶部的照片
@property (strong, nonatomic) UIImageView *topImageView;
// 毛玻璃
@property (strong, nonatomic) UIVisualEffectView *effectView;

@property (nonatomic, strong) YJUsreInfoModel *userModel;


@end

@implementation YJMineNewVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //把选中数组存成全局变量
    [self getUserInfo];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getUserInfo{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/user/getCurrentUserInfo",BaseUrl] parameters:nil success:^(id responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:dict[@"code"] forKey:@"code"];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSDictionary *data = dict[@"data"];
            self.guideStatus = data[@"guideStatus"];
            
            NSDictionary *usrInfo = data[@"userInfo"];
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
            [NSKeyedArchiver archiveRootObject:usrInfo toFile:path];
            
            
            XXLog(@"%@",self.guideStatus);
            self.userModel = [YJUsreInfoModel mj_objectWithKeyValues:usrInfo];
            if (self.userModel.headUrl) {
                [self.icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
                [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"big_horse"]];
            }
            
            
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                
                [[EMClient sharedClient] loginWithUsername:self.userModel.ID
                                                  password:self.userModel.imPwd
                                                completion:^(NSString *aUsername, EMError *aError) {
                                                    if (!aError) {
                                                        NSLog(@"登陆成功");
                                                        [[EMClient sharedClient].options setIsAutoLogin:YES];
                                                        
                                                    } else {
                                                        NSLog(@"登陆失败");
                                                    }
                                                }];
                
            }
            
            self.nickName.text = self.userModel.nickName;
            self.NoLab.text = [NSString stringWithFormat:@"NO:%@",self.userModel.userNo];
            self.rankLab.text = dict[@"data"][@"gradeName"];
            
            [self.tableView reloadData];
            
        }else{
            
            self.nickName.text = @"未登录";
        }
        
        
    } failure:^(NSError *error) {
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
        XXLog(@"失败");
        
        XXLog(@"%@",error);
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO; //默认是YES
    self.tableView.tableFooterView = [UIView new];
    
    //    [self setImage];
    
    //    if (self.tableView.style == UITableViewStylePlain) {
    //        UIEdgeInsets contentInset = self.tableView.contentInset;
    //        contentInset.top = -20;
    //        [self.tableView setContentInset:contentInset];
    //    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
    [self.tableView registerClass:[YJTableCollectionCell class] forCellReuseIdentifier:@"cell"];
    
    [self setImage];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下的话 为负数
    CGFloat off_y = scrollView.contentOffset.y;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    // 下拉超过照片的高度的时候
    if (off_y < - 200)
    {
        CGRect frame = self.topImageView.frame;
        // 这里的思路就是改变 顶部的照片的 frame
        self.topImageView.frame = CGRectMake(0, off_y, frame.size.width, -off_y);
        self.effectView.frame = self.topImageView.frame;
        // 对应调整毛玻璃的效果
        self.effectView.alpha = 1 + (off_y + 200) / kHeight ;
    }
}

- (void)setImage{
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -200, screen_width, 200))];
    _topImageView.image = [UIImage imageNamed:@"big_horse"];
    [self.topImageView setImageToBlur:self.topImageView.image
                           blurRadius:5
                      completionBlock:^(){
                      }];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.clipsToBounds = YES;
    self.topImageView.userInteractionEnabled = YES;
    [self.tableView addSubview:self.topImageView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = _topImageView.frame;
    _effectView = effectView;
    [self.topImageView addSubview:_effectView];
    
    
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom ];
    [self.topImageView addSubview:setting];
    [setting setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setting addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    setting.sd_layout.topSpaceToView(self.topImageView, 10).rightSpaceToView(self.topImageView, 10).heightIs(20).widthIs(20);

    
    
    self.icon = [[UIImageView alloc]init];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
    [self.topImageView addSubview:self.icon];
    self.icon.sd_layout.leftSpaceToView(self.topImageView,10).centerYEqualToView(self.topImageView).heightIs(80 * KWidth_Scale).widthIs(80 * KWidth_Scale);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width / 2;
    self.icon.layer.borderColor = BackGray.CGColor;
    self.icon.layer.borderWidth = 1.0;
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.icon addGestureRecognizer:tapGest];
  

    
    self.nickName = [[UILabel alloc]init];
    [self.topImageView addSubview:self.nickName];
    self.nickName.text = @"未登录";
    self.nickName.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.nickName.textColor = [UIColor whiteColor];
    self.nickName.sd_layout.leftSpaceToView(self.icon, 5).centerYEqualToView(self.icon).heightIs(20).widthIs(100);
    
    
    
    
    self.NoLab = [[UILabel alloc]init];
    [self.topImageView addSubview:self.NoLab];
    self.NoLab.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.NoLab.textColor = [UIColor whiteColor];
    self.NoLab.sd_layout.leftSpaceToView(self.icon,5).topSpaceToView(self.nickName,5).heightIs(20).widthIs(100);
    
    
    UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    view.userInteractionEnabled = YES;
    [self.topImageView addSubview:view];
    view.sd_layout.rightSpaceToView(self.topImageView, -10).centerYEqualToView(self.topImageView).heightIs(40).widthIs(120);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 8;
    view.layer.borderColor = TextColor.CGColor;
    view.layer.borderWidth = 0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goInIntegral)];
    [view addGestureRecognizer:tap];
    
    
    UIImageView *medal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"s_logo"]];
    medal.userInteractionEnabled = YES;
    [view addSubview:medal];
    medal.sd_layout.leftSpaceToView(view, 5).centerYEqualToView(view).heightIs(20).widthIs(18);
    
    UIImageView *accow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    accow.userInteractionEnabled = YES;
    [view addSubview:accow];
    accow.sd_layout.rightSpaceToView(view,15).centerYEqualToView(view).heightIs(12).widthIs(10);

    
    self.rankLab = [[UILabel alloc]init];
    [view addSubview:self.rankLab];
    self.rankLab.text = @"实习向导";
    self.rankLab.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    self.rankLab.textColor = [UIColor whiteColor];
    self.rankLab.sd_layout.leftSpaceToView(medal,5).centerYEqualToView(view).heightIs(20).rightSpaceToView(accow, 5);
    
}

//进入设置
- (void)goSetting{
    
    [self.navigationController pushViewController:[YJSetUpController new] animated:YES];
}

//进入积分页面
- (void)goInIntegral{
    
    XXLog(@"进入积分页面");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code = [userDefault objectForKey:@"code"];
    if ([code isEqualToString:@"1"]){
        [self.navigationController pushViewController:[YJRankVC new] animated:YES];

    }else{
        
        [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
    }
    
    
}


//点击头像进入编辑
- (void)tapClick{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code = [userDefault objectForKey:@"code"];
    if ([code isEqualToString:@"1"]) {
        [self.navigationController pushViewController:[YJSetUserController new] animated:YES];
        
    }else{
        
        [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
    }
}

#pragma mark - table view dataSource table view delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       return screen_width;
    
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//      
//        cell.contentView.userInteractionEnabled = YES;
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//        cell.selectedBackgroundView = [[UIView alloc] init];
//        UIView *view = [self createItemWithCount:9 rows:3 columns:3];
//        [cell addSubview:view];
//    }
    
    YJTableCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - btn delegate

- (void)index:(NSInteger)index{
    
    XXLog(@"点击了第%ld个按钮",index);
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code = [userDefault objectForKey:@"code"];
    if ([code isEqualToString:@"1"]){
        
        switch (index) {
            case 0:
                
                if ([self.guideStatus isEqual:@"2"]) {
                    [self.navigationController pushViewController:[YJGuideCenterController new] animated:YES];

                }else{
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:self.guideStatus alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
 
                }
                
                break;
            case 1:
                
                //签到
                
                break;
            case 2:
                [self.navigationController pushViewController:[YJIntegralVC new] animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:[YJMyOrderController new] animated:YES];

                break;
            case 4:
                [self.navigationController pushViewController:[YJMineEvaluateVC new] animated:YES];

                break;
            case 5:
                [self.navigationController pushViewController:[YJMineShareVC new] animated:YES];

                break;
            case 6:{
                XWPopMenuController *vc = [[XWPopMenuController alloc]init];
                UIImage *img = [UIImage imageWithCaputureView:self.view];
                vc.backImg = img;
                vc.guideSate = self.guideStatus;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            case 7:
                 [self.navigationController pushViewController:[YJCollectController new] animated:YES];
                break;
            case 8:
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
                    NSString *phone = [NSString stringWithFormat:@"tel://0574-87844680"];
                    NSURL *url = [NSURL URLWithString:phone];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                        
                        if (!success) {
                            SGAlertView *alert = [[SGAlertView alloc]initWithTitle:@"提示" contentTitle:@"拨号失败" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                                
                            }];
                            alert.sure_btnTitleColor = TextColor;
                            [alert show];
                        }
                        
                    }];
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0574-87844680"]];
                }
                break;
                
            default:
                break;
        }
        
    }else{
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"未登录，是否立即登录？" alertViewBottomViewType:(SGAlertViewBottomViewTypeTwo) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            if (index == 1) {
                [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
                
            }
            
        }];
        alertV.sure_btnTitleColor = TextColor;
        alertV.sure_btnTitle = @"登录";
        [alertV show];
    }
    
    
}


//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}



@end
