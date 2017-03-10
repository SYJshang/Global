//
//  YJReveingDetailVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJReveingDetailVC.h"
#import "YJDescOrderCell.h"
#import "YJOrderDetailModel.h"
#import "YJSerModel.h"



@interface YJReveingDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSMutableArray *serverList; //服务列表
@property (nonatomic, strong) NSDictionary *payMethodMap; //支付方式

@property (nonatomic, strong) YJOrderDetailModel *detailModel; //详情


@end

@implementation YJReveingDetailVC

- (NSMutableArray *)serverList{
    
    if (_serverList == nil) {
        _serverList = [NSMutableArray array];
    }
    
    return _serverList;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"订单详情" font:19.0];
    
//    [self setBtn];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setBtn{
    
    //拒绝接单
    UIButton *reduse = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduse setTitle:@"拒绝接单" forState:UIControlStateNormal];
    [reduse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:reduse];
    [reduse addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    reduse.tag = 1;
    reduse.layer.borderColor = BackGray.CGColor;
    reduse.layer.borderWidth = 0.5;
    reduse.sd_layout.leftEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);
   
    //联系客户
    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
    [lianxi setTitle:@"联系客户" forState:UIControlStateNormal];
    [lianxi setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:lianxi];
    [lianxi addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    lianxi.tag = 2;
    lianxi.layer.borderColor = BackGray.CGColor;
    lianxi.layer.borderWidth = 0.5;
    lianxi.sd_layout.leftSpaceToView(reduse,0).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);

    //联系客户
    UIButton *jiedan = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiedan setTitle:@"接单" forState:UIControlStateNormal];
    [jiedan setBackgroundColor:TextColor];
    [jiedan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:jiedan];
    [jiedan addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    jiedan.tag = 3;
    jiedan.layer.borderColor = BackGray.CGColor;
    jiedan.layer.borderWidth = 0.5;
    jiedan.sd_layout.leftSpaceToView(lianxi,0).bottomSpaceToView(self.view,0).heightIs(44).rightSpaceToView(self.view,0);
    
}

- (void)btnClick:(UIButton *)btn{
    
    XXLog(@"点击了第%ld个按钮",(long)btn.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    
    self.titleArr = @[@"订单号",@"预订人名称",@"购买时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"联系电话",@"微信",@"其他备注",@"支付方式",@"支付金额"];
    self.payMethodMap = [NSDictionary dictionary];
    
    
    [self getNetWorkData];

    // Do any additional setup after loading the view.
}


- (void)getNetWorkData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.orderId forKey:@"orderId"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/findByOrderId",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.detailModel = [YJOrderDetailModel mj_objectWithKeyValues:dict[@"data"][@"order"]];
            self.serverList = [YJSerModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderDetailList"]];
            self.payMethodMap = dict[@"data"][@"payMethodMap"];
            
            [self.tableView reloadData];
            
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];

        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}



#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArr.count;
    }else{
       return self.serverList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        cell.name.text = self.titleArr[indexPath.row];
//        @[@"订单号",@"预订人名称",@"购买时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"联系电话",@"微信",@"其他备注",@"支付方式",@"支付金额"]
        switch (indexPath.row) {
            case 0:
                cell.desc.text = self.detailModel.orderNo;
                break;
            case 1:
                cell.desc.text = self.detailModel.nickName;
                break;
            case 2:
                cell.desc.text = self.detailModel.buyTime;
                break;
            case 3:
                cell.desc.text = [NSString stringWithFormat:@"%ld人",self.detailModel.personNumber];
                break;
            case 4:
                cell.desc.text = self.detailModel.beginDate;
                break;
            case 5:
                cell.desc.text = self.detailModel.endDate;
                break;
            case 6:
                cell.desc.text = [NSString stringWithFormat:@"%ld天",self.detailModel.serviceNumber];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
                break;
            case 7:
                cell.desc.text = self.detailModel.phone;
                break;
            case 8:
                cell.desc.text = self.detailModel.wechat;
                break;
            case 9:
                cell.desc.text = self.detailModel.remark;
                break;
            case 10:
                XXLog(@"%@",self.payMethodMap[self.detailModel.payMethod]);
                cell.desc.text = self.payMethodMap[self.detailModel.payMethod];
                break;
            case 11:
                cell.desc.text = [NSString stringWithFormat:@"￥%@",self.detailModel.totalMoney];
                cell.desc.textColor = TextColor;
                break;
            default:
                break;
        }

    }else if(indexPath.section == 1){
        
        YJSerModel *model = self.serverList[indexPath.row];
        cell.name.text = model.productName;
        cell.desc.text = model.productDesc;

    }
    
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
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
