//
//  YJReveingDetailVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJRefundDetailVC.h"
#import "YJDescOrderCell.h"
#import "YJGuideRefundModel.h"
#import "YJChatVC.h"



@interface YJRefundDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSMutableArray *serverList; //服务列表
@property (nonatomic, strong) NSDictionary *payMethodMap; //支付方式

@property (nonatomic, strong) YJGuideRefundModel *detailModel; //详情


@end

@implementation YJRefundDetailVC

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
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setBtn{
    
    //拒绝接单
    UIButton *reduse = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduse setTitle:@"联系用户" forState:UIControlStateNormal];
    [reduse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:reduse];
    [reduse addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    reduse.tag = 1;
    reduse.layer.borderColor = BackGroundColor.CGColor;
    reduse.layer.borderWidth = 0.5;
    reduse.sd_layout.leftEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 2);
    //联系客户
    UIButton *jiedan = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiedan setTitle:@"订单详情" forState:UIControlStateNormal];
    [jiedan setBackgroundColor:TextColor];
    [jiedan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:jiedan];
    [jiedan addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    jiedan.tag = 2;
    jiedan.layer.borderColor = BackGroundColor.CGColor;
    jiedan.layer.borderWidth = 0.5;
    jiedan.sd_layout.leftSpaceToView(reduse,0).bottomSpaceToView(self.view,0).heightIs(44).rightSpaceToView(self.view,0);

    
    
}

- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:self.detailModel.buyerId conversationType:EMConversationTypeChat];
        vc.title = self.detailModel.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        
        NSString *text;
        
        text = self.detailModel.typeName;
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:text alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    
    self.titleArr = @[@"订单号",@"退款单号",@"预订人名称",@"退款方式",@"退款原因",@"退款状态",@"申请时间",@"退款时间",@"交易金额",@"退款金额"];
    self.payMethodMap = [NSDictionary dictionary];
    
    
    [self getNetWorkData];
    
    // Do any additional setup after loading the view.
}




- (void)getNetWorkData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.orderId forKey:@"refundId"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/findRefundByOrderId",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.detailModel = [YJGuideRefundModel mj_objectWithKeyValues:dict[@"data"]];
            
            [self setBtn];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
//    self.titleArr = @[,@"退款原因",@"退款状态",@"申请时间",@"退款时间",@"交易金额",@"退款金额"];
    
        cell.name.text = self.titleArr[indexPath.row];
        switch (indexPath.row) {
            case 0:
                cell.desc.text = self.detailModel.orderNo;
                break;
            case 1:
                cell.desc.text = self.detailModel.refundNo;
                break;
            case 2:
                cell.desc.text = self.detailModel.nickName;
                break;
            case 3:
                cell.desc.text = self.detailModel.payMethodName;
                break;
            case 4:
                cell.desc.text = self.detailModel.refundReason;
                break;
            case 5:
                cell.desc.text = self.detailModel.statusName;
                break;
            case 6:
                cell.desc.text = self.detailModel.applyTime;
                break;
            case 7:
                cell.desc.text = self.detailModel.refundTime;
                break;
            case 8:
                cell.desc.text = [NSString stringWithFormat:@"￥%ld",self.detailModel.tradeMoney];
                break;
            case 9:
                 cell.desc.text = [NSString stringWithFormat:@"￥%ld",self.detailModel.refundMoney];
                cell.desc.textColor = TextColor;
                break;

            default:
                break;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
