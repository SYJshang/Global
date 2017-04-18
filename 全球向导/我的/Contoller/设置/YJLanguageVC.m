
//
//  YJLanguageVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/28.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJLanguageVC.h"


static NSString *appLanguage = @"appLanguage";


@interface YJLanguageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YJLanguageVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"语言") font:19.0];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGray;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackGray;

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.currentIndex = 0;
    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    NSString *inx = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndex"];
    if (inx) {
        self.currentIndex = [inx integerValue];
  
    }
    
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = YJLocalizedString(@"跟随系统");
            break;
        case 1:
            cell.textLabel.text = YJLocalizedString(@"中文");
            break;
        case 2:
            cell.textLabel.text = YJLocalizedString(@"繁体中文");
            break;
        case 3:
            cell.textLabel.text = YJLocalizedString(@"英文");
            break;
        default:
            break;
    }
    
    if (self.currentIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    
    
    UIView *line = [[UIView alloc]init];
    [cell.contentView addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(cell.contentView,5).rightSpaceToView(cell.contentView, 5).bottomSpaceToView(cell.contentView, 0).heightIs(1);
    
    cell.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentIndex = indexPath.row;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",self.currentIndex] forKey:@"currentIndex"];
    
    if (indexPath.row == 0) {
        
        
    }else if (indexPath.row == 1){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"state"];
        
    }else if (indexPath.row == 2){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:appLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"state"];
    
    }else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:appLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"state"];
 
    }
    
    [self.tableView reloadData];
    

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
