//
//  YJMineController.m
//  全球向导
//
//  Created by SYJ on 2016/11/3.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJMineController.h"
#import "YJProfileCell.h"
#import "XWPopMenuController.h"
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
//#import "YJIssueVC.h"
#import "YJMineShareVC.h"
#import "UIImageView+WebCache.h"

@interface YJMineController ()<UITableViewDataSource,UITableViewDelegate,YJBtnClickPublic>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIButton *goInGuide;//进入向导主页
@property (nonatomic, strong) UIButton *nickName; //昵称名称
@property (nonatomic, strong) YJUsreInfoModel *userModel;
@property (nonatomic, strong) NSString *guideStatus;
// 顶部的照片
@property (strong, nonatomic) UIImageView *topImageView;
// 毛玻璃
@property (strong, nonatomic) UIVisualEffectView *effectView;

@end

@implementation YJMineController

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
            XXLog(@"%@",self.userModel);
            if (self.userModel.headUrl) {
                [self.icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
                [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"big_horse"]];
            }
            
            [self setBtnStatus];
            
            
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                
                [[EMClient sharedClient] loginWithUsername:self.userModel.ID
                                                  password:self.userModel.imPwd
                                                completion:^(NSString *aUsername, EMError *aError) {
                                                    if (!aError) {
                                                        [[EMClient sharedClient].options setIsAutoLogin:YES];

                                                    } else {
                                                    }
                                                }];

            }
            
        [self.tableView reloadData];
            
        }else{
            
            [self.goInGuide setTitle:@"申请成为全球向导" forState:UIControlStateNormal];
            [self.nickName setTitle:@"未登录" forState:UIControlStateNormal];
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


- (void)setBtnStatus{
    
    if (self.guideStatus) {
        
        NSInteger guideSta = [[self guideStatus] integerValue];
        
        // 0普通用户 1申请中 2正常 3申请不通过 4账号被封
        switch (guideSta) {
            case 0:
                [self.goInGuide setTitle:@"申请成为全球向导" forState:UIControlStateNormal];
                [self.nickName setTitle:self.userModel.nickName forState:UIControlStateNormal];
                break;
            case 1:
                [self.goInGuide setTitle:@"全球向导申请中" forState:UIControlStateNormal];
                [self.nickName setTitle:self.userModel.nickName forState:UIControlStateNormal];
                break;
            case 2:
                [self.goInGuide setTitle:@"进入全球向导" forState:UIControlStateNormal];
                [self.nickName setTitle:self.userModel.nickName forState:UIControlStateNormal];
                break;
            case 3:
                [self.goInGuide setTitle:@"申请失败" forState:UIControlStateNormal];
                self.goInGuide.enabled = NO;
                [self.nickName setTitle:self.userModel.nickName forState:UIControlStateNormal];
                break;
            case 4:
                [self.goInGuide setTitle:@"账号封号处理中" forState:UIControlStateNormal];
                self.goInGuide.enabled = NO;
                [self.nickName setTitle:self.userModel.nickName forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }else{
        
        [self.goInGuide setTitle:@"申请成为全球向导" forState:UIControlStateNormal];
        self.goInGuide.enabled = NO;
        [self.nickName setTitle:@"未登录" forState:UIControlStateNormal];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self setTableView];
    
    
    // Do any additional setup after loading the view.
}

- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStyleGrouped];
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

    [self setImage];
    
    [self.tableView registerClass:[YJProfileCell class] forCellReuseIdentifier:@"firstcell"];
    
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

    
    self.icon = [[UIImageView alloc]init];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    [self.topImageView addSubview:self.icon];
    self.icon.sd_layout.centerXEqualToView(self.topImageView).centerYEqualToView(self.topImageView).heightIs(90 * KWidth_Scale).widthIs(90 * KWidth_Scale);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width / 2;
    self.icon.layer.borderColor = BackGroundColor.CGColor;
    self.icon.layer.borderWidth = 1.0;
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.icon addGestureRecognizer:tapGest];
    
    //进入向导主页按钮
    self.goInGuide = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topImageView addSubview:self.goInGuide];
    self.goInGuide.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    [self.goInGuide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.goInGuide.sd_layout.rightSpaceToView(self.topImageView,0).topSpaceToView(self.topImageView,20).heightIs(20).widthIs(120 * KWidth_Scale);
    [self.goInGuide addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = [UIColor whiteColor];
//    [view addSubview:line];
//    line.sd_layout.centerXEqualToView(view).bottomSpaceToView(view,10).heightIs(20).widthIs(1);
    
    
    self.nickName = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topImageView addSubview:self.nickName];
    [self.nickName setTitle:@"未登录" forState:UIControlStateNormal];
    self.nickName.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    [self.nickName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nickName.sd_layout.centerXEqualToView(self.icon).topSpaceToView(self.icon,10).heightIs(20).widthIs(100);
    [self.nickName addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
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

- (void)remove{
    
    if (self.guideStatus) {
        
        NSInteger guideSta = [[self guideStatus] integerValue];
        
        // 0普通用户 1申请中 2正常 3申请不通过 4账号被封
        switch (guideSta) {
            case 0:
                XXLog(@"跳转到申请向导界面");
                break;
            case 1:
                XXLog(@"向导申请中");
                break;
            case 2:
                [self.navigationController pushViewController:[YJGuideCenterController new] animated:YES];
                break;
            case 3:
                XXLog(@"申请失败");
                break;
            case 4:
                XXLog(@"账号封号处理中");
                break;
                
            default:
                break;
        }
    }else{
        XXLog(@"跳转到申请向导界面");
    }
}

- (void)login{
    
    if (self.guideStatus) {
    
        [self.navigationController pushViewController:[YJSetUserController new] animated:YES];
    }else{
        [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
    }
}


#pragma mark - table view dataSource table view delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 90 * KHeight_Scale;
    }
    return 50;
    
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
    {
        return 10.f;
    }
    
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
    
    {
        return 0.01f;
    }



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        YJProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstcell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 49, screen_width - 20, 0.5)];
        [cell.contentView addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];

        switch (indexPath.section) {
            case 1:
                if (indexPath.row == 0) {
            cell.textLabel.text = YJLocalizedString(@"我的订单");
            cell.imageView.image = [UIImage imageNamed:@"my-order"];
                }else if (indexPath.row == 1){
            cell.textLabel.text = YJLocalizedString(@"我的评价");
            cell.imageView.image = [UIImage imageNamed:@"my-evaluation"];
                }else if (indexPath.row == 2){
            cell.textLabel.text = YJLocalizedString(@"我的发布");
            cell.imageView.image = [UIImage imageNamed:@"my-publish"];
            line.hidden = YES;
                }
                break;
            case 2:
                
            cell.textLabel.text = YJLocalizedString(@"设置");
            cell.imageView.image = [UIImage imageNamed:@"settings"];
            line.hidden = YES;
                
                break;
            
            case 3:
                
            cell.textLabel.text = YJLocalizedString(@"客服中心");
            cell.imageView.image = [UIImage imageNamed:@"service-center"];
            line.hidden = YES;
                
                break;
                
            default:
                break;
        }

        
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code =  [userDefault objectForKey:@"code"];
    
    if ([code isEqualToString:@"1"]){
        if (indexPath.section == 2) {
            
            [self.navigationController pushViewController:[YJSetUpController new] animated:YES];
        }
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            
            [self.navigationController pushViewController:[YJMyOrderController new] animated:YES];
            
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            
            [self.navigationController pushViewController:[YJMineEvaluateVC new] animated:YES];
            
        }
        
        if (indexPath.section == 1 && indexPath.row == 2) {
            
            [self.navigationController pushViewController:[YJMineShareVC new] animated:YES];
            
        }
 
        
    }else{
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"未登录，请登录后重试！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];

        
    }
    
    
    if (indexPath.section == 3) {
        
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
    }
}

- (void)btnDidClickPlusButton:(NSInteger)ViewTag{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *code =  [userDefault objectForKey:@"code"];

    if ([code isEqualToString:@"1"]) {
        if (ViewTag == 11) {
            XWPopMenuController *vc = [[XWPopMenuController alloc]init];
            UIImage *img = [UIImage imageWithCaputureView:self.view];
            vc.backImg = img;
            vc.guideSate = self.guideStatus;
            [self.navigationController pushViewController:vc animated:NO];
        }else if (ViewTag == 12){
            
            [self.navigationController pushViewController:[YJCollectController new] animated:YES];
            
        }
    }else{
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"未登录，请登录后重试！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
             [self presentViewController:[YJLoginFirstController new] animated:NO completion:nil];
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];

    }
    
   
    
}


//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
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
