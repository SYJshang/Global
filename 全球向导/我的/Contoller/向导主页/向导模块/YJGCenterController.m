//
//  YJGCenterController.m
//  全球向导
//
//  Created by SYJ on 2016/12/13.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGCenterController.h"
#import "YJTableVC.h"
#import "UIImage+ImageEffects.h"
#import "CustomHeader.h"
#import "YJMyFindVC.h"
#import "YJDateVC.h"
#import "YJPhotoVC.h"
#import "YJServerStateVC.h"
#import "YJGuideInformationModel.h"

//#import "UIImage+ImageEffects.h"

void *CustomHeaderInsetObserver = &CustomHeaderInsetObserver;
@interface YJGCenterController ()

@property (nonatomic, strong) CustomHeader *header;
@property (nonatomic, strong) YJGuideInformationModel *infoModel;



@end

@implementation YJGCenterController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Do any additional setup after loading the view.
    
    [self addObserver:self forKeyPath:@"segmentTopInset" options:NSKeyValueObservingOptionNew context:CustomHeaderInsetObserver];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO;
    
    [self removeObserver:self forKeyPath:@"segmentTopInset"];
    
//
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
 
    [self.navigationController.navigationBar setTranslucent:YES];


    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(instancetype)init
{
    //发现
    YJMyFindVC *find = [[YJMyFindVC alloc] init];
    //相册
    YJPhotoVC *albumPhoto = [[YJPhotoVC alloc]init];
    //日期
    YJDateVC *date = [[YJDateVC alloc]init];
    //资料
    YJTableVC *information = [[YJTableVC alloc] init];
    
    
    self = [super initWithControllers:find,albumPhoto,date,information, nil];
    if (self) {
        // your code
        self.segmentMiniTopInset = 64;
        self.headerHeight = 200 * KHeight_Scale;
    }
    
    return self;
}


#pragma mark - override

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView
{
    if (_header == nil) {
        _header = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
        _header.backgroundColor = [UIColor redColor];
    }
    return _header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getNetWork];
   
}

- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/getCurrentGuide",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = dict[@"data"];
            
            self.infoModel = [YJGuideInformationModel mj_objectWithKeyValues:data[@"guide"]];
            
            [self.header.imageView sd_setImageWithURL:[NSURL URLWithString:self.infoModel.coverPhotoUrl] placeholderImage:[UIImage imageNamed:@"bg2"]];
            [self.header.headImageView sd_setImageWithURL:[NSURL URLWithString:self.infoModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
            self.header.nameLab.text = self.infoModel.realName;
            
//            self.curStatus = data[@"curIdMap"];
//            [self.tableView reloadData];
            
            XXLog(@"%@",self.infoModel);
            XXLog(@"%@",data);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
 
}

-(UIImage *)createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (context == CustomHeaderInsetObserver) {
        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
        [self.header updateHeadPhotoWithTopInset:inset];
    }
}

-(void)dealloc
{
    
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
