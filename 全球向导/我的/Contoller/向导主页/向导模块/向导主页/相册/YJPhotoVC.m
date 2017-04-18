
//
//  YJPhotoVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/28.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJPhotoVC.h"
#import "YJPhotoTitleVC.h"
#import "YJEditPhotoVC.h"
#import "TZTestCell.h"
#import "YJPhotoAlbumCell.h"
#import "YJPhotoModel.h"
#import "YJEditPhotoVC.h"

@interface YJPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *albumLists; //相册列表



@end

@implementation YJPhotoVC

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
    
//    self.view.userInteractionEnabled = YES;

    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    //layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate = self;
    collect.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[YJPhotoAlbumCell class] forCellWithReuseIdentifier:@"cellid"];
    
    self.collectionView = collect;
    
    [self.view addSubview:self.collectionView];

    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/album/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            self.albumLists = [YJPhotoModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"albumList"]];
            XXLog(@"%lu",(unsigned long)self.albumLists.count);
            
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
    return self.albumLists.count + 1;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    YJPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    //    cell.line.layer.position = cell.line.frame.origin;
    //    cell.line.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //    cell.line.transform=CGAffineTransformScale(cell.line.transform,-1.5,-1.5);
    
    
    
    if (indexPath.row == 0) {
        cell.imgIcon.image = [UIImage imageNamed:@"add_photo"];
        cell.text.text = @"添加相册";
    }else{
        YJPhotoModel *model = self.albumLists[indexPath.row - 1];
        [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:model.coverPicUrl] placeholderImage:[UIImage imageNamed:@"bg1"]];
        cell.text.font = [UIFont boldSystemFontOfSize:AdaptedWidth(14)];
        cell.text.text = [NSString stringWithFormat:@"%@  %@张",model.name,model.picNumber];
        
    }
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
    
    
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[YJPhotoTitleVC new] animated:YES];
    }else{
        YJPhotoModel *model = self.albumLists[indexPath.row - 1];

        YJEditPhotoVC *vc = [[YJEditPhotoVC alloc]init];
        vc.albumId = model.ID;
        vc.album = model.name;
        vc.corPic = model.coverPicUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - segmentTitle delegate

-(NSString *)segmentTitle
{
    return YJLocalizedString(@"向导相册");
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
