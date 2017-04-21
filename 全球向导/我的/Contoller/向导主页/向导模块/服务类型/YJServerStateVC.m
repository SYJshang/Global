//
//  YJServerStateVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJServerStateVC.h"
#import "YJServerStateCell.h"
#import "YJOtherServerVC.h"
#import "YJEditServerVC.h"
#import "YJServerStateModle.h"
#import "YJPageModel.h"

@interface YJServerStateVC ()<UITableViewDelegate,UITableViewDataSource,editBtnClickPush>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray *titleArr;
//@property (nonatomic, strong) NSArray *descArr;
//@property (nonatomic, strong) NSArray *iconArr;

@property (nonatomic, strong) NSMutableArray *serverList;
@property (nonatomic, strong) YJPageModel *pageModel;


@end

@implementation YJServerStateVC

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
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"服务类型" font:19.0];
    
    [self getServerList];

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJServerStateCell class] forCellReuseIdentifier:@"cell"];
    
//
//    self.titleArr = @[@"徒步接机",@"带车接机",@"徒步陪游",@"带车陪游",@"徒步送机",@"带车送机"];
//    self.iconArr = @[@"icon3",@"icon4",@"icon5",@"icon6",@"icon7",@"icon8"];
//    self.descArr = @[@"搭乘公交地铁等接机",@"向导专车接机",@"搭乘公交陪游",@"向导专车陪游",@"搭乘公众交通送机",@"向导开车送机"];
    
    // Do any additional setup after loading the view.
}


- (void)getServerList{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"1" forKey:@"currentPage"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/product/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.serverList = [YJServerStateModle mj_objectArrayWithKeyValuesArray:dict[@"data"][@"productList"]];
            
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryProduct"][@"page"]];
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
    
    return 130 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.serverList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJServerStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    YJServerStateModle *model = self.serverList[indexPath.row];
    cell.model = model;

    cell.delegate = self;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    [self.navigationController pushViewController:[YJOtherServerVC new] animated:YES];
    
}

- (void)editClickPush:(UIButton *)sender{
   
    YJServerStateCell *cell = (YJServerStateCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    YJServerStateModle *model = self.serverList[indexPath.row];
    
    if (sender.tag == 2) {
        XXLog(@"点击进入编辑页面");
        YJEditServerVC *vc = [[YJEditServerVC alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        
        
        
        [self startServe:model];
        
    }
    
  
}

- (void)startServe:(YJServerStateModle *)model{
   
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:model.ID forKey:@"id"];
    if (model.status == 0) {
        [parameter setObject:@"1" forKey:@"status"];
 
    }else{
        [parameter setObject:@"0" forKey:@"status"];
    }
    
  
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/product/updateStatus",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
           
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"修改成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];

            
            if (model.status == 0) {
                model.status = 1;
            }else{
                model.status = 0;
            }

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
