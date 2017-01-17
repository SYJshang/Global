
//
//  YJTravelController.m
//  全球向导
//
//  Created by SYJ on 2016/12/2.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTravelController.h"
#import "UINavigationBar+Awesome.h"

static CGFloat imageH = 200;
static CGFloat navH = 64;

@interface YJTravelController ()<UITableViewDelegate,UITableViewDataSource,SGActionSheetDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImage *shadowImage;



@end

@implementation YJTravelController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(imageH, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.frame = CGRectMake(0, -imageH, screen_width, imageH);
    self.headerView.image = [UIImage imageNamed:@"bg1"];
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.headerView];
    [self.tableView insertSubview:self.headerView atIndex:0];
    self.headerView.userInteractionEnabled = YES;
    
    YJDIYButton *btn = [YJDIYButton buttonWithtitle:@"更换封面" Block:^{
        
        XXLog(@"更换封面");
        
        SGActionSheet *sheet = [[SGActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册",@"相机"]];
        sheet.messageTextColor = TextColor;
        [sheet show];
        
        
    }];
    [self.headerView addSubview:btn];
    btn.sd_layout.centerXEqualToView(self.headerView).centerYEqualToView(self.headerView).heightIs(AdaptedWidth(30)).widthIs(AdaptedWidth(120));
    btn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    
}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)finsh{
    
    XXLog(@"发布");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"发布" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"发布行程" font:19.0];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.shadowImage = self.navigationController.navigationBar.shadowImage;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    [self changeNavAlphaWithConnentOffset:offsetY];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.shadowImage = self.shadowImage;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"XXXX";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    
    if (offsetY < -imageH) {
        NSLog(@"开始改变");
        CGRect f = self.headerView.frame;
        f.origin.y = offsetY;
        f.size.height =  -offsetY;
        self.headerView.frame = f;
    }
    
    [self changeNavAlphaWithConnentOffset:offsetY];
}

-(void)changeNavAlphaWithConnentOffset:(CGFloat)offsetY
{
    UIColor *color = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    if (offsetY > -navH * 2 ) {
        NSLog(@"渐渐不透明");
        CGFloat alpha = MIN(1, 1 - ((-navH * 2 + navH - offsetY) / navH));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        self.title = @"个人主页";
    }
    else {
        NSLog(@"渐渐透明");
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
    }
}


#pragma mark - actionSheet delegate
- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath{
    
    if (indexPath == 0) {
        XXLog(@"打开相册");
    }else{
        XXLog(@"打开相机");

    }
    
}


@end
