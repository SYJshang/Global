//
//  YJOrderStateController.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOrderStateController.h"
#import "YJStateCell.h"
#import "YJStateModle.h"

#define WIDTH_OF_PROCESS_LABLE (300 *[UIScreen mainScreen].bounds.size.width / 375)


@interface YJOrderStateController ()<UITableViewDelegate,UITableViewDataSource>
//存储数组
@property(strong,nonatomic)NSMutableArray * dataList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJOrderStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self setData];
}
-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 108) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)setData
{
    self.dataList=[NSMutableArray arrayWithCapacity:0];
    NSDictionary *dic=@{@"timeStr":@"2016-07-20",@"titleStr":@"第一步",@"detailSrtr":@"标题:关于zls是不是宇宙最帅的讨论"};
    YJStateModle *model=[[YJStateModle alloc]initData:dic];
    [self.dataList addObject:model];
    
    NSDictionary *dic2=@{@"timeStr":@"2016-07-21",@"titleStr":@"第二步",@"detailSrtr":@"关于zls是不是宇宙最帅的讨论关于zls是不是宇宙最帅的讨论"};
    YJStateModle *model2=[[YJStateModle alloc]initData:dic2];
    [self.dataList addObject:model2];
    
    NSDictionary *dic3=@{@"timeStr":@"2016-07-22",@"titleStr":@"第三步",@"detailSrtr":@"关于zls是不是宇宙最帅的讨论关于z"};
    YJStateModle *model3=[[YJStateModle alloc]initData:dic3];
    [self.dataList addObject:model3];
    
    NSDictionary *dic4=@{@"timeStr":@"2016-07-23",@"titleStr":@"第四步",@"detailSrtr":@"关于zls是不是宇宙最帅的讨论关于zls是不是宇宙最帅的讨论"};
    YJStateModle *model4=[[YJStateModle alloc]initData:dic4];
    [self.dataList addObject:model4];
    
    NSDictionary *dic5=@{@"timeStr":@"2016-07-24",@"titleStr":@"第五步",@"detailSrtr":@"关于zls是不是宇宙最帅的讨论"};
    YJStateModle *model5=[[YJStateModle alloc]initData:dic5];
    [self.dataList addObject:model5];
    NSDictionary *dic6=@{@"timeStr":@"2016-07-25",@"titleStr":@"第六步",@"detailSrtr":@"关于zls是不是宇宙最"};
    YJStateModle *model6=[[YJStateModle alloc]initData:dic6];
    [self.dataList addObject:model6];
    NSDictionary *dic7=@{@"timeStr":@"2016-07-26",@"titleStr":@"第七步",@"detailSrtr":@"关于zls是"};
    YJStateModle *model7=[[YJStateModle alloc]initData:dic7];
    [self.dataList addObject:model7];
    [self.tableView reloadData];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"testTime";
    YJStateCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[YJStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    YJStateModle * model = self.dataList[indexPath.row];
    cell.model = model;
    if (indexPath.row == self.dataList.count - 1) {
        cell.verticalLabel2.backgroundColor = TextColor;
        cell.circleView.backgroundColor = [UIColor whiteColor];
        cell.circleView.layer.borderColor = TextColor.CGColor;
    }else{
        cell.verticalLabel2.backgroundColor =  TextColor;
        cell.circleView.backgroundColor = TextColor;
        cell.circleView.layer.borderColor = TextColor.CGColor;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJStateModle * model = self.dataList[indexPath.row];
    NSDictionary * fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE, 0);
    CGSize titleLabelSize=[model.detailSrtr boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
    if (titleLabelSize.height < 15) {
        titleLabelSize.height = 40;
    }else{
        titleLabelSize.height = titleLabelSize.height + 30;
    }
    return titleLabelSize.height + 50;
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
