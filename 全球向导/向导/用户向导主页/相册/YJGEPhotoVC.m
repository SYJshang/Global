
//
//  YJPhotoVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/28.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGEPhotoVC.h"
#import "YJGEEditPhotoVC.h"
#import "TZTestCell.h"
#import "YJGEPhotoAlbumCell.h"
#import "YJPhotoModel.h"
#import "YJGEEditPhotoVC.h"
#import "NoNetwork.h"

@interface YJGEPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *albumLists; //相册列表

@property (nonatomic, strong) NoNetwork *noNetWork;



@end

@implementation YJGEPhotoVC

- (NSMutableArray *)albumLists{
    
    if (_albumLists == nil) {
        _albumLists = [NSMutableArray array];
    }
    return _albumLists;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getNetWork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.view.userInteractionEnabled = YES;

    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    //layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate = self;
    collect.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[YJGEPhotoAlbumCell class] forCellWithReuseIdentifier:@"cellid"];
    
    self.collectionView = collect;
    
    [self.view addSubview:self.collectionView];

    // Do any additional setup after loading the view.
}


//设置网络状态
- (void)NetWorks{
    
    self.collectionView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    //    self.noNetWork.imageView.frame = CGRectMake(100, screen_height - 340,screen_width - 200, 160);
    //    self.noNetWork.titleLabel.frame = CGRectMake(40, self.noNetWork.imageView.bottom , screen_width - 80, 40);
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}

- (void)noDatas{
    
    self.collectionView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.btrefresh.hidden = YES;
    self.noNetWork.titleLabel.text = @"暂无数据\n赶快去整出动静吧";
    //    self.noNetWork.imageView.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
    //    self.noNetWork.titleLabel.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
    //    self.noNetWork.imageView.frame = CGRectMake(100, screen_height - 340 * KHeight_Scale,screen_width - 200, 160);
    //    self.noNetWork.titleLabel.frame = CGRectMake(40, self.noNetWork.imageView.bottom , screen_width, 40);
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}



- (void)getNetWork{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/listAlbum/%@",BaseUrl,self.ID] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            self.albumLists = [YJPhotoModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"albumList"]];
            XXLog(@"%lu",(unsigned long)self.albumLists.count);
            
            if (self.albumLists.count == 0) {
                [self noDatas];
            }
            
            [self.collectionView reloadData];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumLists.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    YJGEPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    //    cell.line.layer.position = cell.line.frame.origin;
    //    cell.line.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //    cell.line.transform=CGAffineTransformScale(cell.line.transform,-1.5,-1.5);
    
    
    
        YJPhotoModel *model = self.albumLists[indexPath.row];
        [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:model.coverPicUrl] placeholderImage:[UIImage imageNamed:@"bg1"]];
        cell.text.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
        cell.text.text = [NSString stringWithFormat:@"%@  %@张",model.name,model.picNumber];
    
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widt = [UIScreen mainScreen].bounds.size.width / 2;
    return CGSizeMake(widt - 10,widt + 10);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //    [cell setBackgroundColor:[UIColor greenColor]];
    
    NSLog(@"点击了%ld个",indexPath.row);
    
        YJPhotoModel *model = self.albumLists[indexPath.row];

        YJGEEditPhotoVC *vc = [[YJGEEditPhotoVC alloc]init];
        vc.albumId = model.ID;
        vc.album = model.name;
        vc.corPic = model.coverPicUrl;
        [self.navigationController pushViewController:vc animated:YES];
    
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消了%ld个",indexPath.row);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - segmentTitle delegate

-(NSString *)segmentTitle
{
    return @"相册";
}

-(UIScrollView *)streachScrollView
{
    return self.collectionView;
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
