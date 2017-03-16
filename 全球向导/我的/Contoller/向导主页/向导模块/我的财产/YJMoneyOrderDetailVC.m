
//
//  YJMoneyOrderDetailVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/15.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMoneyOrderDetailVC.h"
#import "YJMoneyDetailModel.h"

@interface YJMoneyOrderDetailVC (){
    
    UILabel *name;
    UILabel *money;
    UILabel *type;
    UILabel *orderNo;
    UILabel *time;
    UILabel *userMoney; //剩余金额
}

@property (nonatomic, strong) YJMoneyDetailModel *model;


@end

@implementation YJMoneyOrderDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"订单明细" font:19.0];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getNetWork];
    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/account/viewFundsLog/%@",BaseUrl,self.ID] parameters:nil success:^(id responseObject) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
            XXLog(@"%@",dict);
            
            self.model = [YJMoneyDetailModel mj_objectWithKeyValues:dict[@"data"][@"fundsLog"]];
            NSDictionary *typeMap = dict[@"data"][@"typeMap"];
            NSDictionary *flowMap = dict[@"data"][@"flowMap"];
            
            NSString *str = [NSString stringWithFormat:@"%ld",self.model.flow];
            name.text = flowMap[str];
            money.text = self.model.money;
            type.text = typeMap[self.model.type];
            time.text = self.model.addTime;
            orderNo.text = self.model.orderNo;
            userMoney.text = self.model.useMoney;
            
        }
        
    } failure:^(NSError *error) {
        
        XXLog(@"%@",error);
        
    }];
}



- (void)initUI{

    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view,0).topSpaceToView(self.view, 20).heightIs(60);
    
    name = [[UILabel alloc]init];
    [view addSubview:name];
    name.textColor = [UIColor grayColor];
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:AdaptedWidth(18)];
    name.sd_layout.leftSpaceToView(view, 10).topSpaceToView(view, 0).heightRatioToView(view, 1).widthIs(120);
    
    
    money = [[UILabel alloc]init];
    [view addSubview:money];
    money.textColor = TextColor;
    money.textAlignment = NSTextAlignmentRight;
    money.font = [UIFont boldSystemFontOfSize:AdaptedWidth(22)];
    money.sd_layout.rightSpaceToView(view, 10).topSpaceToView(view, 0).heightRatioToView(view, 1).widthIs(200);
    
    UIView *view1 = [[UIView alloc]init];
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    view1.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(view, 10).heightIs(100);
   
    //类型
    UILabel *tyName = [[UILabel alloc]init];
    [view1 addSubview:tyName];
    tyName.textColor = [UIColor grayColor];
    tyName.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    tyName.text = @"类    型";
    tyName.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(view1, 0).widthIs(80).heightRatioToView(view1, 0.25);
    
    type = [[UILabel alloc]init];
    [view1 addSubview:type];
    type.textAlignment = NSTextAlignmentRight;
    type.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    type.textColor = [UIColor blackColor];
    type.sd_layout.leftSpaceToView(tyName, 10).rightSpaceToView(view1, 10).centerYEqualToView(tyName).heightRatioToView(view1, 0.25);
    
    //交易单号
    UILabel *order = [[UILabel alloc]init];
    [view1 addSubview:order];
    order.textColor = [UIColor grayColor];
    order.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    order.text = @"交易单号";
    order.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(tyName, 0).widthIs(80).heightRatioToView(view1, 0.25);
    
    orderNo = [[UILabel alloc]init];
    [view1 addSubview:orderNo];
    orderNo.textAlignment = NSTextAlignmentRight;
    orderNo.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    orderNo.textColor = [UIColor blackColor];
    orderNo.sd_layout.leftSpaceToView(order, 10).rightSpaceToView(view1, 10).centerYEqualToView(order).heightRatioToView(view1, 0.25);
    
    //交易时间
    UILabel *addtime = [[UILabel alloc]init];
    [view1 addSubview:addtime];
    addtime.textColor = [UIColor grayColor];
    addtime.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    addtime.text = @"交易时间";
    addtime.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(order, 0).widthIs(80).heightRatioToView(view1, 0.25);
    
    time = [[UILabel alloc]init];
    [view1 addSubview:time];
    time.textAlignment = NSTextAlignmentRight;
    time.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    time.textColor = [UIColor blackColor];
    time.sd_layout.leftSpaceToView(addtime, 10).rightSpaceToView(view1, 10).centerYEqualToView(addtime).heightRatioToView(view1, 0.25);
    
    //剩余金额
    UILabel *shengyu = [[UILabel alloc]init];
    [view1 addSubview:shengyu];
    shengyu.textColor = [UIColor grayColor];
    shengyu.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    shengyu.text = @"剩余金额";
    shengyu.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(addtime, 0).widthIs(80).heightRatioToView(view1, 0.25);
    
    userMoney = [[UILabel alloc]init];
    [view1 addSubview:userMoney];
    userMoney.textAlignment = NSTextAlignmentRight;
    userMoney.font = [UIFont boldSystemFontOfSize:AdaptedWidth(16)];
    userMoney.textColor = TextColor;
    userMoney.sd_layout.leftSpaceToView(shengyu, 10).rightSpaceToView(view1, 10).centerYEqualToView(shengyu).heightRatioToView(view1, 0.25);
    
    
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
