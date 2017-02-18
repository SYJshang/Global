
//
//  YJFindCollectVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/13.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJFindCollectVC.h"
#import "YJGuideRecommendCell.h"
#import "YJNFindGuideModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"


@interface YJFindCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YJPageModel *pageModel; //页数
@property (nonatomic, strong) NSMutableArray *findList; //新发现列表

@property (nonatomic, strong) NoNetwork *noNetWork; //空白页面

@end

@implementation YJFindCollectVC

- (NSMutableArray *)findList{
    
    if (_findList == nil) {
        _findList = [NSMutableArray array];
    }
    return _findList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self setTableView];
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    // Do any additional setup after loading the view.
}


//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


//加载tableView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJGuideRecommendCell class] forCellReuseIdentifier:@"cell"];
    
    [self getNetWork];
    
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myColGuideRec/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.findList = [YJNFindGuideModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"colGuideRecList"]];
        
        self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryColGuideRec"][@"page"]];
        
        if (self.findList.count == 0) {
            
            self.tableView.hidden = YES;
            
            self.noNetWork = [[NoNetwork alloc]init];
            self.noNetWork.titleLabel.text = @"暂无数据\n赶紧搞出点事情吧...";
//            self.noNetWork.btnBlock = ^{
//                [weakSelf getNetWork];
//            };
            self.noNetWork.btrefresh.hidden = YES;
            
            [self.view addSubview:self.noNetWork];

        }else{
            
            [self.noNetWork removeFromSuperview];
            self.tableView.hidden = NO;
        }
        
        
        XXLog(@"%@",self.pageModel.nextPage);
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}




#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.findList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190 * KWidth_Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJGuideRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    YJNFindGuideModel *model = self.findList[indexPath.row];
    cell.model = model;
    if (model.status == 0) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.6;
        [cell.contentView addSubview:view];
        view.sd_layout.leftSpaceToView(cell.contentView,0).bottomSpaceToView(cell.contentView,0).heightIs(60 * KHeight_Scale).rightSpaceToView(cell.contentView,0);
        
        UILabel *label = [[UILabel alloc]init];
        [view addSubview:label];
        label.text = @"已失效";
        label.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        label.textColor = [UIColor whiteColor];
        label.sd_layout.leftSpaceToView(view,10).centerYEqualToView(view).widthIs(80 * KWidth_Scale).heightIs(20);
        
        
        YJDIYButton *btn = [YJDIYButton imageName:@"photo_delete" Block:^{
            XXLog(@"%ld",indexPath.row);
        }];
        [view addSubview:btn];
        btn.sd_layout.rightSpaceToView(view,10).centerYEqualToView(view).heightIs(20).widthIs(20);
        
    }

    
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
