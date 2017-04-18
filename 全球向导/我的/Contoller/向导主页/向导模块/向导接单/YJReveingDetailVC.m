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
#import "YJChatVC.h"



@interface YJReveingDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSMutableArray *serverList; //服务列表

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
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"订单详情") font:19.0];
    
//    [self setBtn];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setBtn:(NSInteger)state{
    
    //拒绝接单
    UIButton *reduse = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *jiedan = [UIButton buttonWithType:UIButtonTypeCustom];


    if (state == 1 || state == 7) {
        [reduse setTitle:@"拒绝接单" forState:UIControlStateNormal];
        [reduse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:reduse];
        [reduse addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        reduse.tag = 1;
        reduse.layer.borderColor = BackGroundColor.CGColor;
        reduse.layer.borderWidth = 0.5;
        reduse.sd_layout.leftEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);
        
        //联系客户
        [lianxi setTitle:@"联系客户" forState:UIControlStateNormal];
        [lianxi setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:lianxi];
        [lianxi addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        lianxi.tag = 2;
        lianxi.layer.borderColor = BackGroundColor.CGColor;
        lianxi.layer.borderWidth = 0.5;
        lianxi.sd_layout.leftSpaceToView(reduse,0).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);
        
        //联系客户
        [jiedan setTitle:@"接单" forState:UIControlStateNormal];
        [jiedan setBackgroundColor:TextColor];
        [jiedan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:jiedan];
        [jiedan addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        jiedan.tag = 3;
        jiedan.layer.borderColor = BackGroundColor.CGColor;
        jiedan.layer.borderWidth = 0.5;
        jiedan.sd_layout.leftSpaceToView(lianxi,0).bottomSpaceToView(self.view,0).heightIs(44).rightSpaceToView(self.view,0);

  
    }else{
        
        [reduse setTitle:@"联系用户" forState:UIControlStateNormal];
        [reduse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:reduse];
        [reduse addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        reduse.tag = 1;
        reduse.layer.borderColor = BackGroundColor.CGColor;
        reduse.layer.borderWidth = 0.5;
        reduse.sd_layout.leftEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 2);
        
        [jiedan setTitle:@"订单详情" forState:UIControlStateNormal];
        [jiedan setBackgroundColor:TextColor];
        [jiedan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:jiedan];
        [jiedan addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        jiedan.tag = 2;
        jiedan.layer.borderColor = BackGroundColor.CGColor;
        jiedan.layer.borderWidth = 0.5;
        jiedan.sd_layout.leftSpaceToView(reduse,0).bottomSpaceToView(self.view,0).heightIs(44).rightSpaceToView(self.view,0);

    }
    
    
    
}

- (void)btnClick:(UIButton *)btn{
    
    XXLog(@"点击了第%ld个按钮",(long)btn.tag);
    
    if (btn.tag == 1) {
        [self reduseOrder:self.detailModel.ID];
    }else if (btn.tag == 2){
        
        YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:self.detailModel.buyerId conversationType:EMConversationTypeChat];
        vc.title = self.detailModel.nickName;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self receiveOrder:self.detailModel.ID];

    }
    
}


- (void)btnClick1:(UIButton *)btn{
    
    XXLog(@"点击了第%ld个按钮",(long)btn.tag);
    
    if (btn.tag == 1) {
        
        YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:self.detailModel.buyerId conversationType:EMConversationTypeChat];
        vc.title = self.detailModel.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
       
        
        NSString *text;
        if ([self.detailModel.successTypeName isKindOfClass:[NSNull class]] || [self.detailModel.successTypeName isEqualToString:@""] || self.detailModel.successTypeName == nil) {
            text = self.detailModel.closeTypeName;
            
        }else{
            
            text = self.detailModel.successTypeName;
            
        }
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:text alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
        
    }

}


#pragma mark - 拒绝接单

- (void)reduseOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/trade/cancel",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"拒绝接单成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];
            
            
            [self getNetWorkData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 接单

- (void)receiveOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/trade/receive",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"接单成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];
            
            [self getNetWorkData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    
    self.titleArr = @[@"订单号",@"预订人名称",@"购买时间",@"超时时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"支付方式",@"支付金额",@"交易状态",@"订单状态",@"联系电话",@"微信",@"其他备注"];


    
    
    [self getNetWorkData];

    // Do any additional setup after loading the view.
}


- (void)getNetWorkData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.orderId forKey:@"orderId"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/findByOrderId",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.detailModel = [YJOrderDetailModel mj_objectWithKeyValues:dict[@"data"][@"order"]];
            self.serverList = [YJSerModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderDetailList"]];
            
            [self setBtn:self.detailModel.status];
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithWhite:0.99 alpha:1.0];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.backgroundColor = TextColor;
        [view addSubview:lab];
        lab.sd_layout.leftSpaceToView(view, 10).centerYEqualToView(view).heightIs(25).widthIs(3);
        
        
        UILabel *text = [[UILabel alloc]init];
        text.textColor = TextColor;
        [view addSubview:text];
        text.text = @"服务类型";
        text.font = [UIFont boldSystemFontOfSize:AdaptedWidth(15)];
        text.textColor = [UIColor blackColor];
        text.sd_layout.leftSpaceToView(lab, 5).centerYEqualToView(view).heightIs(25).widthIs(200);
    
        return view;

    
}

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
//self.titleArr = @[@"订单号",@"预订人名称",@"购买时间",@"超时时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"支付方式",@"支付金额",@"订单状态",@"联系电话",@"微信",@"其他备注"];
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
                
                cell.desc.text = self.detailModel.limitTime;

                break;
            case 4:
                cell.desc.text = [NSString stringWithFormat:@"%ld人",self.detailModel.personNumber];

                break;
            case 5:
                cell.desc.text = self.detailModel.beginDate;

                break;
            case 6:
                cell.desc.text = self.detailModel.endDate;

               
                break;
            case 7:
                cell.desc.text = [NSString stringWithFormat:@"%ld天",self.detailModel.serviceNumber];
                cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
                
                break;
            case 8:
                cell.desc.text = self.detailModel.payMethodName;
                break;
            case 9:
                
                cell.desc.text = [NSString stringWithFormat:@"￥%@",self.detailModel.totalMoney];
                cell.desc.textColor = TextColor;
                
                
                break;
            case 10:
                cell.desc.text = self.detailModel.statusName;

                break;
            case 11:
                
                cell.desc.text = self.detailModel.statusName;
                break;
            case 12:
                cell.desc.text = self.detailModel.phone;

                break;
            case 13:
                cell.desc.text = self.detailModel.wechat;

                break;
            case 14:
                cell.desc.text = self.detailModel.remark;

                break;
            default:
                break;
        }

    }else if(indexPath.section == 1){
        
        YJSerModel *model = self.serverList[indexPath.row];
        cell.name.text = model.productName;
        cell.desc.text = model.productDesc;

    }
    
    if ([cell.desc.text isKindOfClass:[NSNull class]] || [cell.desc.text isEqualToString:@""] || cell.desc.text == nil) {
        
        cell.desc.text = @"无";
        
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


@end
