//
//  YJDetailOrderController.m
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDetailOrderController.h"
#import "YJDescOrderCell.h"
#import "YJConfirmCell.h"
#import "YJUserOrderDetailModel.h"
#import "YJSerModel.h"


@interface YJDetailOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *descArr;

@property (nonatomic, strong) NSMutableArray *serverList; //服务列表
@property (nonatomic, strong) NSDictionary *payMethodMap; //支付方式

@property (nonatomic, strong) YJUserOrderDetailModel *userlModel; //详情

@end

@implementation YJDetailOrderController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
 
    [self setBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn];
//    [btn setTitle:@"ceshi" forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor grayColor]];
//    btn.frame = CGRectMake(0, 563, screen_width, 40);
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, screen_width, screen_height - 148) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJConfirmCell class] forCellReuseIdentifier:@"cell1"];
    
    self.titleArr = @[@"订单号",@"购买时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"联系电话",@"微信",@"其他备注",@"支付方式",@"支付金额"];
    self.payMethodMap = [NSDictionary dictionary];

//    self.descArr = @[@"1天",@"6人",@"1234567890",@"￥100 * 3",@"无",@"￥3000"];
    
    [self getNetWork];
    // Do any additional setup after loading the view.
}

- (void)setBtn{
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, screen_height - 44, screen_width, 1);
    view.backgroundColor = BackGray;
    
    
    
    
    YJButton *guide_home = [[YJButton alloc]initWithFrame:CGRectMake(0, screen_height - 43, 80 * KWidth_Scale, 43)];
    [self.view addSubview:guide_home];
    [guide_home setBackgroundColor:[UIColor whiteColor]];
    [guide_home setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [guide_home setTitle:YJLocalizedString(@"向导主页") forState:UIControlStateNormal];
    [guide_home setImage:[UIImage imageNamed:@"guide_home"] forState:UIControlStateNormal];
    
    
    YJButton *contact_guide = [[YJButton alloc]initWithFrame:CGRectMake(80 * KWidth_Scale, screen_height - 43, 80 * KWidth_Scale, 43)];
    [self.view addSubview:contact_guide];
    [contact_guide setBackgroundColor:[UIColor whiteColor]];
    [contact_guide setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [contact_guide setTitle:YJLocalizedString(@"联系向导") forState:UIControlStateNormal];
    [contact_guide setImage:[UIImage imageNamed:@"contact_guide"] forState:UIControlStateNormal];
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buy];
    buy.frame = CGRectMake(160 * KWidth_Scale, screen_height - 43, screen_width - (160 * KWidth_Scale), 43);
    buy.backgroundColor = TextColor;
    [buy setTitle:YJLocalizedString(@"付款") forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)getNetWork{
   
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.ID forKey:@"orderId"];
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/findByOrderId",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            XXLog(@"成功");
            
            self.userlModel = [YJUserOrderDetailModel mj_objectWithKeyValues:dict[@"data"][@"order"]];
            self.serverList = [YJSerModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderDetailList"]];
            self.payMethodMap = dict[@"data"][@"payMethodMap"];
            
            [self.tableView reloadData];
            
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.titleArr.count;

        }else{
            return self.serverList.count;
 
        }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.row == 0 && indexPath.section == 0) {
        return 120;
    }

    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        
            
            YJConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.userlModel.showPicUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
            cell.name.text = [NSString stringWithFormat:@"%@/%@",self.userlModel.realName,self.userlModel.smallTitle];
            return cell;
        }else if (indexPath.section == 1){
            
//            @[@"订单号",@"购买时间",@"人数",@"开始时间",@"结束时间",@"服务天数",@"联系电话",@"微信",@"其他备注",@"支付方式",@"支付金额"]
            YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.name.text  =  self.titleArr[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.desc.text = self.userlModel.orderNo;
                    break;
                case 1:
                    cell.desc.text = self.userlModel.buyTime;
                    break;
                case 2:
                    cell.desc.text = [NSString stringWithFormat:@"%ld人",self.userlModel.personNumber];
                    break;
                case 3:
                    cell.desc.text = self.userlModel.beginDate;
                    break;
                case 4:
                    cell.desc.text = self.userlModel.endDate;
                    break;
                case 5:
                    cell.desc.text = [NSString stringWithFormat:@"%ld天",self.userlModel.serviceNumber];
//                    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
                    break;
                case 6:
                    cell.desc.text = self.userlModel.phone;
                    break;
                case 7:
                    cell.desc.text = self.userlModel.wechat;
                    break;
                case 8:
                    cell.desc.text = self.userlModel.remark;
                    break;
                case 9:
                    cell.desc.text = self.userlModel.payMethodName;
                    break;
                case 10:
                    cell.desc.text = [NSString stringWithFormat:@"￥%ld",(long)self.userlModel.totalMoney];
                    break;
                default:
                    break;
            }

            
            return cell;

            
        }else if (indexPath.section == 2){
        
        YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        YJSerModel *model = self.serverList[indexPath.row];
        cell.name.text = model.productName;
        cell.desc.text = model.productDesc;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
