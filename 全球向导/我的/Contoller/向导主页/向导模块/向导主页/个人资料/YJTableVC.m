//
//  YJTableVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/13.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTableVC.h"
#import "YJDescOrderCell.h"
#import "YJTimeCell.h"
#import "YJWroldMineVC.h"
#import "YJGuideInformationModel.h"


@interface YJTableVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) YJGuideInformationModel *infoModel;
@property (nonatomic, strong) NSDictionary *curStatus;



@end

@implementation YJTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNetWork];
    
    self.titleArr = @[@"真实姓名",@"身份证验证",@"向导类型",@"生日",@"性别",@"目前身份"];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJTimeCell class] forCellReuseIdentifier:@"cell1"];
    
    // Do any additional setup after loading the view.
}

- (void)setNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/getCurrentGuide",BaseUrl] parameters:nil success:^(id responseObject) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = dict[@"data"];
            
            self.infoModel = [YJGuideInformationModel mj_objectWithKeyValues:data[@"guide"]];
            self.curStatus = data[@"curIdMap"];
            [self.tableView reloadData];
            
            XXLog(@"%@",self.infoModel);
            XXLog(@"%@",data);
 
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSString *)segmentTitle
{
    return YJLocalizedString(@"向导资料");
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArr.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
            YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.name.text = self.titleArr[indexPath.row];
            cell.desc.textAlignment = NSTextAlignmentRight;

            switch (indexPath.row) {
                case 0:
                    cell.desc.text = self.infoModel.realName;
                    return cell;
                    break;
                case 1:
                    cell.desc.text = @"已验证";
                    cell.desc.layer.masksToBounds = YES;
                    cell.desc.textColor = TextColor;
                    return cell;
                    break;
                case 2:
                    cell.desc.text =  self.infoModel.typeName;
                    return cell;
                    break;
                case 3:
                    cell.desc.text = self.infoModel.birth;
                    return cell;
                    break;
                case 4:
                    if (self.infoModel.sex == 0) {
                        cell.desc.text = @"女";
                    }else{
                        cell.desc.text = @"男";
                    }
                    return cell;
                    break;
                default:
                    break;
            }
//
        if (indexPath.row == 5) {
                YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
                cell.title.text = @"目前身份";
            switch (self.infoModel.curId) {
                case 1:
                    cell.time.text = self.curStatus[@"1"];
                    break;
                case 2:
                    cell.time.text = self.curStatus[@"2"];
                    break;
                case 3:
                    cell.time.text = self.curStatus[@"3"];
                    break;
                case 4:
                    cell.time.text = self.curStatus[@"4"];
                    break;
                    
                default:
                    break;
            }
                cell.tag = 1;
    
                return cell;
        }
            

            
            
        
    }
    
    if (indexPath.section == 1) {
        YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.name.text = @"座右铭";
        cell.desc.text = self.infoModel.motto;
        cell.desc.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    
    if (indexPath.section == 2) {
        YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.title.text = @"全球中的我";
        cell.time.text =  @"";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXLog(@"123456");

    if (indexPath.section == 0 && indexPath.row == self.titleArr.count - 1) {
        
        XXLog(@"........");
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        YJTimeCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"目前身份" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"学生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            XXLog(@"选择学生");
            cell.time.text = @"学生";
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"在职员工" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"选择在职员工");
            cell.time.text = @"在职员工";
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"自由职业者" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"选择自由职业者");
            cell.time.text = @"自由职业者";
        }];
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"其他职业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"选择其他职业");
            cell.time.text = @"其他职业";
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];

        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (indexPath.section == 2) {
        [self.navigationController pushViewController:[YJWroldMineVC new] animated:YES];
    }
    
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
