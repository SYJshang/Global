//
//  YJOrderFormController.m
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOrderFormController.h"
#import "YJNameIconCell.h"
#import "YJAddNumCell.h"
#import "YJTimeCell.h"
#import "YJServerCell.h"
#import "YJPhoneNumCell.h"
#import "YJSubmitCell.h"
#import "SDAutoLayout.h"
#import "YJConfirmController.h"
#import "YJDataController.h"
#import "YJLoginFirstController.h"
#import "YJGuideModel.h"
#import "YJProductModel.h"
//#import "YJSelsectArr.h"


@interface YJOrderFormController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
//总价
@property (nonatomic, strong) UILabel *priceAll;
//提交
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) NSMutableArray *DateArr;//日期数组
@property (nonatomic, strong) NSMutableArray *productArr;//向导服务

@property (nonatomic, strong) YJGuideModel *guideModel;

@end

@implementation YJOrderFormController



- (NSMutableArray *)DateArr{
    
    if (_DateArr == nil) {
        
        _DateArr = [NSMutableArray array];
    }
    
    return _DateArr;
    
}

- (NSMutableArray *)productArr{
    
    if (_productArr == nil) {
        
        _productArr = [NSMutableArray array];
    }
    
    return _productArr;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"订单详情" font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = leftItem;
    //加载一个布局
    [self setLayout];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 104) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = BackGray;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJNameIconCell class] forCellReuseIdentifier:@"first"];
    [self.tableView registerClass:[YJAddNumCell class] forCellReuseIdentifier:@"second"];
    [self.tableView registerClass:[YJTimeCell class] forCellReuseIdentifier:@"three"];
    [self.tableView registerClass:[YJServerCell class] forCellReuseIdentifier:@"four"];
    [self.tableView registerClass:[YJPhoneNumCell class] forCellReuseIdentifier:@"five"];
    [self.tableView registerClass:[YJSubmitCell class] forCellReuseIdentifier:@"six"];
    
    

}
    
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self getNetWork];
    
    
    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/toBuy/%@",BaseUrl,self.guideID] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSDictionary *data = dict[@"data"];
            
            self.guideModel = [YJGuideModel mj_objectWithKeyValues:data[@"guide"]];
            self.productArr = [YJProductModel mj_objectArrayWithKeyValuesArray:data[@"productList"]];
            self.DateArr = data[@"disableDateList"];
            
            [self.tableView reloadData];
            
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"未登录" contentTitle:@"是否立即登录" alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
                if (index == 1) {
                    XXLog(@"login");
                    [self presentViewController:[YJLoginFirstController new] animated:YES completion:nil];
                }
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];

            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)setLayout{
    
    self.priceAll = [[UILabel alloc]init];
    self.priceAll.textColor = TextColor;
    self.priceAll.backgroundColor = [UIColor whiteColor];
    self.priceAll.text = @"合计 ￥100";
    [self.view addSubview:self.priceAll];
    self.priceAll.textAlignment = NSTextAlignmentCenter;
    self.priceAll.font = [UIFont systemFontOfSize:17.0];
    self.priceAll.sd_layout.leftSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(40).widthIs(screen_width / 2 - 10);
    self.priceAll.layer.masksToBounds = YES;
    self.priceAll.layer.cornerRadius = 2;
    self.priceAll.layer.borderColor = BackGray.CGColor;
    self.priceAll.layer.borderWidth = 1;
    
    
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = TextColor;
    [self.submitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.sd_layout.leftSpaceToView(self.priceAll,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(40);
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 2;
    self.submitBtn.layer.borderColor = [UIColor colorWithRed:255.0 / 255.0 green:230.0 / 255.0 blue:130.0 / 255.0 alpha:1.0].CGColor;
    self.submitBtn.layer.borderWidth = 1;

}



- (void)click:(UIButton *)sender{
    
    YJConfirmController *vc = [[YJConfirmController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"提交订单");
}

#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section== 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    
    if (section == 2) {
        return self.productArr.count;
    }
    
    if (section == 3) {
        return 2;
    }
    
    if (section == 4) {
        return 1;
    }
    
     return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 ) {
        return 0;
    }

        return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }else{
        return 40;
    }
    
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YJNameIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.guideModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
        cell.name.text = [NSString stringWithFormat:@"%@/%@",self.guideModel.realName,self.guideModel.guideDesc];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            YJAddNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
            
            if (select.count > 0) {
                cell.time.text = [NSString stringWithFormat:@"%@开始",select.firstObject];
//                cell.time.textAlignment = NSTextAlignmentCenter;

                        
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }
        
}
    
    if (indexPath.section == 2) {
        
        YJServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
        YJProductModel *moddel = self.productArr[indexPath.row];
        cell.serverName.text = moddel.name;
        cell.descLab.text = moddel.desc;
        cell.price.text = [NSString stringWithFormat:@"￥%@",moddel.price];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    if (indexPath.section == 3) {
        YJPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"five"];
        switch (indexPath.row) {
            case 0:
                cell.phoneNum.text = @"联系电话";
                cell.phoneTF.placeholder = @"请输入手机号（必填）";
                break;
                
            case 1:
                cell.phoneNum.text = @"微信号";
                cell.phoneTF.placeholder = @"请输入微信号（选填）";
                break;
                
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            YJPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"five"];
            cell.phoneNum.text = @"其他备注";
            cell.phoneTF.placeholder = @"(选填)";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
//        if (indexPath.row == 1) {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//            if(cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        }
//            
//        cell.textLabel.text = @"保险信息";
//        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
}
    
//    if (indexPath.section == 5) {
//        YJSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"six"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            YJDataController *vc = [[YJDataController alloc]init];
            vc.arr = self.DateArr;
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
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
