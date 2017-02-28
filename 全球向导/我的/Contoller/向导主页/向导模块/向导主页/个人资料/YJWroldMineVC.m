//
//  YJWroldMineVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/14.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJWroldMineVC.h"
#import "YJTextCell.h"
#import "YJPictureCell.h"

@interface YJWroldMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *text;

@end

@implementation YJWroldMineVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"全球中的我" font:19.0];
}

- (void)back{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    
    [self.tableView registerClass:[YJTextCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJPictureCell class] forCellReuseIdentifier:@"cell1"];
    
    self.text = @"平凡的寺，平凡的钟，经过诗人艺术的再创造，就构成了一幅情味隽永幽静诱人的江南水乡的夜景图，成为流传古今的名作、名胜。此诗自从欧阳修说了“三更不是打钟时”之后，议论颇多。其实寒山寺夜半鸣钟却是事实，直到宋化仍然。宋人孙觌的《过枫桥寺》诗：“白首重来一梦中，青山不改旧时容。乌啼月落桥边寺，倚枕犹闻半夜钟。”即可为证。张继大概也以夜半鸣钟为异，故有“夜半钟声”一句。今人或以为“乌啼”乃寒山寺以西有“乌啼山”，非指“乌鸦啼叫。”“愁眠”乃寒山寺以南的“愁眠山”，非指“忧愁难眠”。殊不知“乌啼山”与“愁眠山”，却是因张继诗而得名。孙觌的“乌啼月落桥边寺”句中的“乌啼”，即是明显指“乌啼山";

    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [YJTextCell cellHegith:self.text];
    }
    
    return 180 * KHeight_Scale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        YJTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell configCellWithText:self.text];
        return cell;
}
    
    if (indexPath.row > 0 && indexPath.row < 4) {
        YJPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        switch (indexPath.row) {
            case 1:
                cell.icon.image = [UIImage imageNamed:@"backImg"];
                break;
            case 2:
                cell.icon.image = [UIImage imageNamed:@"123"];
                break;
            case 3:
                cell.icon.image = [UIImage imageNamed:@"register_bg"];
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
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
