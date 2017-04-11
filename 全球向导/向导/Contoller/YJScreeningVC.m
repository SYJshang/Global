//
//  YJScreeningVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJScreeningVC.h"
#import "YJScreentimeCell.h"
#import "NSNotification+Extension.h"
#import "YJAllSelectCell.h"
#import "YJDataController.h"
#import "YJGuideTypeModel.h"
#import "YJPriceModel.h"
#import "YJSexModel.h"
#import "YJGuideController.h"


@interface YJScreeningVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) BasicBlock basicBlock;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arrTitle;
@property (nonatomic, strong) NSMutableArray *arritle;
@property (nonatomic,strong)NSMutableArray *storeArr;

@property (nonatomic, strong) NSMutableArray *guideTypeArr;//向导类型arr
@property (nonatomic, strong) NSMutableArray *priceTypeArr;//价格类型arr
@property (nonatomic, strong) NSMutableArray *sexTypeArr;//性别类型arr


@end

@implementation YJScreeningVC

#pragma mark - 懒加载
- (NSMutableArray *)guideTypeArr{
    
    if (_guideTypeArr == nil) {
        _guideTypeArr = [NSMutableArray array];
    }
    
    return _guideTypeArr;
    
}

- (NSMutableArray *)priceTypeArr{
    
    if (_priceTypeArr == nil) {
        _priceTypeArr = [NSMutableArray array];
    }
    
    return _priceTypeArr;
    
}

- (NSMutableArray *)sexTypeArr{
    
    if (_sexTypeArr == nil) {
        

        
        YJSexModel *model1 = [[YJSexModel alloc]init];
        model1.name = @"默认";
        model1.valueId = @"10000000";
        
        YJSexModel *model2 = [[YJSexModel alloc]init];
        model2.name = @"男";
        model2.valueId = @"1";
        
        YJSexModel *model3 = [[YJSexModel alloc]init];
        model3.name = @"女";
        model3.valueId = @"0";

    _sexTypeArr = [NSMutableArray arrayWithObjects:model1,model2,model3, nil];
    
    }
    return _sexTypeArr;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"筛选" font:19.0];
    
    [self getnetWork];
}

- (void)back{
    
    if(self.basicBlock){
        self.basicBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCancleBarItemHandle:(BasicBlock)basicBlock{
    
    self.basicBlock = basicBlock;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    self.storeArr = [NSMutableArray array];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = BackGray;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJScreentimeCell class] forCellReuseIdentifier:NSStringFromClass([YJScreentimeCell class])];
    [self.tableView registerClass:[YJAllSelectCell class] forCellReuseIdentifier:NSStringFromClass([YJAllSelectCell class])];

    // Do any additional setup after loading the view.
}


- (void)getnetWork{
    
//    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/listInit",BaseUrl] parameters:nil success:^(id responseObject) {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        XXLog(@"%@",dict);
//        
//        if ([dict[@"code"] isEqualToString:@"1"]) {
//            
//            NSDictionary *data = dict[@"data"];
    
            //类型
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"user.plist"];
        NSDictionary *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
        self.guideTypeArr = [YJGuideTypeModel mj_objectArrayWithKeyValuesArray:data[@"guideTypeList"]];
        //价格
        self.priceTypeArr = [YJPriceModel mj_objectArrayWithKeyValuesArray:data[@"priceRangeList"]];
        
        YJGuideTypeModel *guideModel = [[YJGuideTypeModel alloc]init];
        guideModel.name = @"默认";
        guideModel.valueId = @"10000000";
        [self.guideTypeArr insertObject:guideModel atIndex:0];
        
        YJPriceModel *priceModel = [[YJPriceModel alloc]init];
        priceModel.name = @"默认";
        priceModel.valueId = @"10000000";
        [self.priceTypeArr insertObject:priceModel atIndex:0];
        
        [self.tableView reloadData];
        [self buildData];

}

- (void)buildData{
    
    self.arritle = [NSMutableArray array];
    MCELLSelect *M = [[MCELLSelect alloc]init];
    M.arrLabel = self.sexTypeArr;
    M.title = @"性别";
    M.seleType = CL_SeleType_Radio;
    [self.arritle addObject:M];
    
    M = [[MCELLSelect alloc]init];
    M.arrLabel = self.priceTypeArr;
    M.title = @"价格区间(元/天)";
    M.seleType = CL_SeleType_Radio;
    [self.arritle addObject:M];
    
//    M = [[MCELLSelect alloc]init];
//    NSMutableArray *pType = [NSMutableArray array];
//    for (YJPriceModel *model in self.priceTypeArr) {
//        [pType addObject:model.name];
//    }
    M = [[MCELLSelect alloc]init];
    M.arrLabel = self.guideTypeArr;
    M.title = @"向导类型";
    M.seleType = CL_SeleType_Radio;
    [self.arritle addObject:M];
    
    [self.tableView reloadData];
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//        return 50;
//    }
    
    if (indexPath.section == 0) {
        YJAllSelectCell *cell = (YJAllSelectCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            CGFloat rect = cell.data.cellHeight;
            return rect;
        }
    }
    
    
        return 70;
   
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    if (section == 0) {
//        return 30;
//    }
//    return 0;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    NSArray *arr = @[@"",@"",@""];
//    
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = BackGray;
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180, 30)];
//    [view addSubview:label];
//    label.text = arr[section];
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
//    label.textAlignment = NSTextAlignmentLeft;
//    return view;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
       return self.arritle.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        YJScreentimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJScreentimeCell class])];
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
//        
//        
//        if (select.count > 0) {
//            cell.tiem.text = [NSString stringWithFormat:@"%@开始",select.firstObject];
//            [self.storeArr addObject:select];
//            //                cell.time.textAlignment = NSTextAlignmentCenter;
//            
//            
//        }
//        return cell;
//    }
    
    if (indexPath.section == 0) {
        YJAllSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJAllSelectCell class])];
        
        MCELLSelect *M = self.arritle[indexPath.row];
        cell.data =  M;
        __weak typeof(cell) cellweak = cell;
        
        [cell setSelctedBlock:^(NSArray *arr) {
            [self.storeArr  addObjectsFromArray:arr];
            [cellweak.titleArray removeAllObjects];
        }];
        
        [cell onint];
        [cell updateData];
        
        cell.backgroundColor = BackGray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    

    
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 15, screen_width - 40 , 40);
    [cell.contentView addSubview:btn];
    btn.backgroundColor = TextColor;
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(finsh) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = BackGray.CGColor;
    btn.layer.borderWidth = 1.0;
    
    cell.backgroundColor = BackGray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)finsh{
    
    XXLog(@"完成");
    [self postNotification:@"CCC"];
    [self postNotification:@"backData" withObject:self.storeArr];
    [self back];
    XXLog(@"%@",self.storeArr);
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
