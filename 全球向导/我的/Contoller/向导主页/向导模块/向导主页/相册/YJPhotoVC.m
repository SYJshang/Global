
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

@interface YJPhotoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YJPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    //    layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate = self;
    collect.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[YJPhotoAlbumCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.view addSubview:collect];

    // Do any additional setup after loading the view.
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
    return 6;
    
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
        cell.imgIcon.image = [UIImage imageNamed:@"AlbumAddBtn"];
        cell.text.text = @"添加相册";
    }else{
        cell.imgIcon.image = [UIImage imageNamed:@"timg"];
        cell.text.text = [NSString stringWithFormat:@"这是第%ld个相册",indexPath.row];
        
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
    
    NSLog(@"点击了%ld个",indexPath.row);
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[YJPhotoTitleVC new] animated:YES];
    }
    
    
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
