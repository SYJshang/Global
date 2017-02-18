//
//  YJGuideController.m
//  全球向导
//
//  Created by SYJ on 2016/10/27.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGuideController.h"
#import "CLSeachBar.h"
#import "XRWaterfallLayout.h"
#import "YJGuideCollectionCell.h"
#import "YJScreeningVC.h"
#import "NSNotification+Extension.h"
#import "YJPageModel.h"
#import "YJGuideTypeModel.h"
#import "YJGuideModel.h"
#import "YJCityModel.h"
#import "YJCollectionReusableView.h"
#import "YJGuideDetailVC.h"


@interface YJGuideController ()<UICollectionViewDataSource, XRWaterfallLayoutDelegate,UICollectionViewDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CLSeachBar *seacher;
@property (nonatomic, strong) UIImageView *cityImg;

@property (nonatomic, strong) NSString *currentPage;//当前页面
@property (nonatomic, strong) NSString *cityId;//当前城市
@property (nonatomic, strong) NSString *beginPrice;//开始价格
@property (nonatomic, strong) NSString *endPrice;//结束价格
@property (nonatomic, strong) NSString *sex;//性别
@property (nonatomic, strong) NSString *type;//类型

@property (nonatomic, strong) YJPageModel *pageModel;
@property (nonatomic, strong) YJCityModel *cityModel;

//@property (nonatomic, strong) NSMutableArray *guidTypeArr;  //向导类型
//@property (nonatomic, strong) NSMutableArray *priceTypeArr;  //价格区间类型
@property (nonatomic, strong) NSMutableArray *guideList; //向导列表
@property (nonatomic, strong) NoNetwork *noNetWork;



@end

@implementation YJGuideController

#pragma mark - 懒加载
//- (NSMutableArray *)guidTypeArr{
//    
//    if (_guidTypeArr == nil) {
//        _guidTypeArr = [NSMutableArray array];
//    }
//    
//    return _guidTypeArr;
//}
//
//- (NSMutableArray *)priceTypeArr{
//    
//    if (_priceTypeArr == nil) {
//        _priceTypeArr = [NSMutableArray array];
//    }
//    return _priceTypeArr;
//}

- (NSMutableArray *)guideList{
    
    if (_guideList == nil) {
        _guideList = [NSMutableArray array];
    }
    return _guideList;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = BackGray;
    
    [self observeNotification:@"backData"];

    
    if ([[YJBNetWorkNotifionTool stringFormStutas] isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }

    
    [self getNetWork];
}

//设置网络状态
//设置网络状态
- (void)NetWorks{
    
    self.collectionView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


- (void)handleNotification:(NSNotification *)notification{
    
    if ([notification is:@"backData"]) {
        
        NSArray *arr = notification.object;
        XXLog(@"......%@",arr);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavitaionSearch];
    
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    //设置各属性的值
    waterfall.rowSpacing = 10;
    waterfall.columnSpacing = 10;
    waterfall.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    
    //或者一次性设置
//    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
     //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
     XRImage *image = self.images[indexPath.item];
     return image.imageH / image.imageW * itemWidth;
     }];
     */
    
    
    
    
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_width,screen_height - 64) collectionViewLayout:waterfall];
    self.collectionView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    
    self.cityImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nearby"]];
    self.cityImg.frame = CGRectMake(5,-150, screen_width - 10, 150);
    [self.collectionView addSubview:self.cityImg];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YJGuideCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[YJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    

    
    
//     上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.guideList.count < 19) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getMoreData];
        }
    }];
}

- (void)getNetWork{
    
    NSMutableDictionary *parametr = [NSMutableDictionary dictionary];
    
    if (self.cityId) {
        [parametr setObject:self.cityId forKey:@"cityId"];
    }
    if (self.beginPrice) {
        [parametr setObject:self.beginPrice forKey:@"beginPrice"];
    }
    if (self.endPrice) {
        [parametr setObject:self.endPrice forKey:@"endPrice"];
    }
    if (self.sex) {
        [parametr setObject:self.sex forKey:@"sex"];
    }
    if (self.type) {
        [parametr setObject:self.type forKey:@"type"];
    }
    
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/listInit",BaseUrl] parameters:parametr success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            [self.noNetWork removeFromSuperview];
            self.collectionView.hidden = NO;
            
            NSDictionary *data = dict[@"data"];
            
            //存储字典，在下个筛选页面会用到
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
            [NSKeyedArchiver archiveRootObject:data toFile:path];

            
            self.pageModel = [YJPageModel mj_objectWithKeyValues:data[@"queryGuide"][@"page"]];
            self.guideList = [YJGuideModel mj_objectArrayWithKeyValuesArray:data[@"guideList"]];
            self.cityModel = [YJCityModel mj_objectWithKeyValues:data[@"city"]];
            
            [self.collectionView.mj_footer endRefreshing];

                [self.collectionView reloadData];
//            [self.collectionView.mj_header endRefreshing];
            

        }
        
    } failure:^(NSError *error) {
      
        [self NetWorks];
        [self.collectionView.mj_header endRefreshing];
    }];
    
}

- (void)getMoreData{
    
    NSMutableDictionary *parametr = [NSMutableDictionary dictionary];
    
    if (self.currentPage) {
        [parametr setObject:self.pageModel.currentPage forKey:@"currentPage"];
    }
    if (self.cityId) {
        [parametr setObject:self.cityId forKey:@"cityId"];
    }
    if (self.beginPrice) {
        [parametr setObject:self.beginPrice forKey:@"beginPrice"];
    }
    if (self.endPrice) {
        [parametr setObject:self.endPrice forKey:@"endPrice"];
    }
    if (self.sex) {
        [parametr setObject:self.sex forKey:@"sex"];
    }
    if (self.type) {
        [parametr setObject:self.type forKey:@"type"];
    }
    
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/listInit",BaseUrl] parameters:parametr success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            [self.noNetWork removeFromSuperview];
            self.collectionView.hidden = NO;
            
            NSDictionary *data = dict[@"data"];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:data[@"queryGuide"][@"page"]];
            self.guideList = [YJGuideModel mj_objectArrayWithKeyValuesArray:data[@"guideList"]];
            self.cityModel = [YJCityModel mj_objectWithKeyValues:data[@"city"]];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
//          [self.collectionView.mj_footer endRefreshingWithNoMoreData];

            
        }
        
    } failure:^(NSError *error) {
        
        [self NetWorks];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}

-(void)viewTapped:(UITapGestureRecognizer *)tap {
    
    [self.seacher endEditing:YES];
    
}


- (void)setNavitaionSearch{
    
    
    self.seacher = [[CLSeachBar alloc] initWithFrame:CGRectMake(0, 7,screen_width * 0.6, 30)];
    self.navigationItem.titleView = self.seacher;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"screening"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 10, 22, 22);
    [btn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    [self styleOne:self.seacher];
    
}



- (void)styleOne:(CLSeachBar *)search
{
    search.placeholder = @"搜索向导/推荐";
    
    search.returnKeyType = UIReturnKeySearch;
    search.font = [UIFont systemFontOfSize:16];
    search.textColor = [UIColor whiteColor];
    [search setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [search setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    search.textColor = [UIColor blackColor];
    //修改为圆角
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = search.frame.size.height*0.2;
    search.layer.borderWidth = 1;
    search.layer.borderColor = TextColor.CGColor;
    search.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"search"];
    search.leftView = imageView;
    // 设置左边的view永远显示
    search.leftViewMode = UITextFieldViewModeUnlessEditing;
    // 设置右边永远显示清除按钮
    search.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)location:(UIButton *)btn{
    
    NSLog(@"点击筛选向导");
    
    YJScreeningVC *suaixuan = [[YJScreeningVC alloc]init];
    [self.navigationController pushViewController:suaixuan animated:YES];
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    
    int y = (arc4random() % 80) + 240;
    
    return y * KHeight_Scale;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *listCount = [NSMutableArray array];
    for (int i = 0; i < self.guideList.count; i ++) {
        YJGuideModel *model = self.guideList[i];
        [listCount addObject:model];
    }
    
    return listCount.count;
}






- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJGuideCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    YJGuideModel *model = self.guideList[indexPath.row];
    cell.guideModel = model;
    
//    cell.imageURL = self.images[indexPath.item].imageURL;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableArray *listCount = [NSMutableArray array];
    for (int i = 0; i < self.guideList.count; i ++) {
        YJGuideModel *model = self.guideList[i];
        [listCount addObject:model];
    }
    YJGuideDetailVC *vc = [[YJGuideDetailVC alloc]init];
    YJGuideModel *modle = listCount[indexPath.row];
    vc.guideId = modle.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        YJCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.imgV.image = [UIImage imageNamed:@"bg2"];
    return headerView;
    }
    UICollectionReusableView *head = [[UICollectionReusableView alloc]init];
    return head;
 }

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(screen_width, 150);
    
}


- (void)dealloc{
    
    self.collectionView = nil;
    self.noNetWork = nil;
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
