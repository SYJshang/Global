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
#import "YJConfirmController.h"
#import "YJDataController.h"
#import "YJLoginFirstController.h"
#import "YJGuideModel.h"
#import "YJProductModel.h"
#import "YJRelateDayCell.h"
#import "YJOrderFinshModel.h"
#import "YJTableView.h"


@interface YJOrderFormController ()<UITableViewDelegate,UITableViewDataSource,MyCustomCellDelegate>{
    
    NSInteger _allPrice;//总价
    NSString *productIds;//服务id
    NSString *numbers;//服务id的数量
    NSString *phone;//手机号
    NSString *wechat;//微信号
    NSString *remark;//其他内容
    NSString *serviceDates;//服务日期
    NSString *serviceNumber;//服务天数
    NSString *personNumber;//服务人数
    
}

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

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //选择的天数
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:saveSelectArr];
    //    NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"订单详情" font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.tableView reloadData];
    
    productIds = @"";//服务id
    numbers = @"";//服务id的数量
    phone = @"";//手机号
    wechat = @"";//微信号
    remark = @"";//其他内容
    serviceDates = @"";//服务日期
    serviceNumber = @"";//服务天数
    personNumber = @"1";
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    if (self.DateArr) {
        [self.DateArr removeAllObjects];
    }
    
    
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
    [self.tableView registerClass:[YJRelateDayCell class] forCellReuseIdentifier:@"seven"];
    
    
    [self getNetWork];
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    // Do any additional setup after loading the view.
}

#pragma mark - 监听上移键盘
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.tableView.contentInset = UIEdgeInsetsZero;
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


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}

- (void)click:(UIButton *)sender{
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];
    //    [self.tableView reloadData];
    [self postData];
    
    NSLog(@"提交订单");
}

#pragma mark - table view dataSource

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.tableView endEditing:YES];
}


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
    
    if (section < 2 ) {
        return 0;
    }
    
    return 40;
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = TextColor;
    [view addSubview:line];
    line.sd_layout.leftSpaceToView(view,5).centerYEqualToView(view).heightIs(15).widthIs(2);
    
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
    [view addSubview:lab];
    lab.sd_layout.leftSpaceToView(line,5).centerYEqualToView(view).heightIs(15).rightSpaceToView(view,10);
    switch (section) {
        case 2:
            lab.text = @"选择服务类型";
            break;
        case 3:
            lab.text = @"联系方式";
            break;
        case 4:
            lab.text = @"其他备注";
            break;
            
        default:
            break;
    }
    
    
    return view;
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
            __weak typeof(cell) Scell = cell;
            
            Scell.peoBlock = ^{
                Scell.people ++;
                Scell.numLab.text = [NSString stringWithFormat:@"%d",Scell.people];
                personNumber = [NSString stringWithFormat:@"%d",Scell.people];
                XXLog(@"%@",personNumber);
                
            };
            
            Scell.peoReduBlock = ^{
                if (Scell.people > 1) {
                    Scell.people --;
                }
                
                NSString *peo = [NSString stringWithFormat:@"%d",Scell.people];
                Scell.numLab.text = peo;
                personNumber = [NSString stringWithFormat:@"%d",Scell.people];
                
            };
            return cell;
            
        }
        
        if (indexPath.row == 1) {
            YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
            
            if (select.count > 0) {
                
                cell.time.text = [NSString stringWithFormat:@"%lu天",(unsigned long)select.count];
            }
            return cell;
        }
        
    }
    
    if (indexPath.section == 2) {
        
        
        YJProductModel *moddel = self.productArr[indexPath.row];
        
        if (self.productArr.count != 0) {
            productIds = [NSString stringWithFormat:@"%@%@,",productIds,moddel.ID];
        }
        
        XXLog(@"productIds >>>>>>>>>>>>%@",productIds);
        
        
        if (moddel.relateDayNumber == 1) {
            
            //选择的天数
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
            
            
            YJServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
            cell.serverName.text = moddel.name;
            
            cell.price.text = [NSString stringWithFormat:@"￥%@ *%lu",moddel.price,select.count];
            __weak typeof(cell) Scell = cell;
            Scell.serverBtn.userInteractionEnabled = NO;
            
            _allPrice = [moddel.price integerValue] * select.count;
            self.priceAll.text = [NSString stringWithFormat:@"总计 ￥%ld",_allPrice];
            
            if (self.productArr.count != 0) {
                
                numbers = [NSString stringWithFormat:@"%@%ld,",numbers,select.count];
                //                    [self totalPrice:moddel];
                
                
            }
            
            
            return cell;
        }else{
            
            YJRelateDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seven"];
            cell.num.text = moddel.name;
            cell.descLab.text = [NSString stringWithFormat:@"%@ *%d",moddel.price,cell.people];
            cell.numLab.text = [NSString stringWithFormat:@"%d",cell.people];
            cell.delegate = self;
            //            [self totalPrice:moddel];
            if (self.productArr.count != 0) {
                
                numbers = [NSString stringWithFormat:@"%@%@,",numbers,cell.numLab.text];
                //                [self totalPrice:moddel];
                
                
            }
            
            XXLog(@"numbers >>>>>>>>>>%@",numbers);
            
            return cell;
        }
    }
    
    if (indexPath.section == 3) {
        YJPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"five"];
        __weak typeof(cell) Scell = cell;
        
        
        switch (indexPath.row) {
            case 0:{
                cell.phoneNum.text = @"联系电话";
                cell.phoneTF.placeholder = @"请输入手机号（必填）";
                cell.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
                
                Scell.text = ^(NSString *sender){
                    
                    phone = sender;
                    XXLog(@"%@",phone);
                    
                };
                //                phone = cell.phoneTF.text;
                break;
            }
            case 1:{
                cell.phoneNum.text = @"微信号";
                cell.phoneTF.placeholder = @"请输入微信号（选填）";
                Scell.text = ^(NSString *sender){
                    
                    wechat = sender;
                    XXLog(@"%@",wechat);
                    
                };
                break;
            }
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            YJPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"five"];
            __weak typeof(cell) Scell = cell;
            cell.phoneNum.text = @"其他备注";
            cell.phoneTF.placeholder = @"(选填)";
            Scell.text = ^(NSString *sender){
                
                remark = sender;
                XXLog(@"%@",remark);
                
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
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
}

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    XXLog(@"%@",index);
    
    YJRelateDayCell *cells = (YJRelateDayCell *)cell;
    
    switch (flag) {
        case 100:
        {
            //做加法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            
            cells.people ++;
            
        }
            break;
        case 101:
        {
            if (cells.people > 0) {
                cells.people --;
            }
            
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [self.tableView reloadData];
    //     [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    YJProductModel *model = self.productArr[index.row];
    //计算总价
    //    [self totalPrice];
    [self totalPrice:model];
    
}

-(void)totalPrice:(YJProductModel *)model
{
    
    //每次算完要重置为0，因为每次的都是全部循环算一遍
    _allPrice = 0;
    productIds = @"";
    self.priceAll.text = [NSString stringWithFormat:@"总计 ￥%ld",_allPrice];
    numbers = @"";
    
    
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    
    for ( int i = 0; i < self.productArr.count; i++)
    {
        YJRelateDayCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];
        
        YJProductModel *model = [self.productArr objectAtIndex:i];
        if (model.relateDayNumber == 1)
        {
            //选择的天数
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
            
            //            _allPrice = _allPrice + [model.price integerValue] * select.count;
            XXLog(@"%ld",_allPrice);
            //            numbers = [NSString stringWithFormat:@"%@%ld,",numbers,select.count];
            
        }else{
            
            _allPrice = _allPrice + [model.price integerValue] * cell.people;
            //            numbers = [NSString stringWithFormat:@"%@%@,",numbers,cell.numLab.text];
            
        }
        
        XXLog(@"%ld",_allPrice);
        XXLog(@"number >>>>%@",numbers);
        
        //给总价文本赋值
        self.priceAll.text = [NSString stringWithFormat:@"总计 ￥%ld",_allPrice];
        NSLog(@"%@",self.priceAll.text);
        
        
    }
    
}

- (void)postData{
    
    
    NSMutableDictionary *parmter = [NSMutableDictionary dictionary];
    [parmter setObject:self.guideID forKey:@"guideId"];
    [parmter setObject:productIds forKey:@"productIds"];
    [parmter setObject:numbers forKey:@"numbers"];
    if (phone.length == 11) {
        [parmter setObject:phone forKey:@"phone"];
    }else{
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"手机号格式有误" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            return;
            
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
    }
    [parmter setObject:wechat forKey:@"wechat"];
    [parmter setObject:remark forKey:@"remark"];
    
    //选择的天数
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
    
    if (select.count > 0) {
        for (NSString *str in select) {
            serviceDates = [NSString stringWithFormat:@"%@%@,",serviceDates,str];
        }
        serviceNumber = [NSString stringWithFormat:@"%ld",select.count];
    }
    [parmter setObject:serviceDates forKey:@"serviceDates"];
    [parmter setObject:serviceNumber forKey:@"serviceNumber"];
    [parmter setObject:personNumber forKey:@"personNumber"];
    
    
    XXLog(@"%@",parmter);
    
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/orderGuide",BaseUrl] parameters:parmter success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            YJConfirmController *vc = [[YJConfirmController alloc]init];
            
            YJOrderFinshModel *model = [YJOrderFinshModel mj_objectWithKeyValues:dict[@"data"]];
            vc.orderID = model.orderId;
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
        
    } failure:^(NSError *error) {
        
        XXLog(@"%@",error);
        
    }];
    
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
