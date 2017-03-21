
//
//  YJEditPhotoVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/28.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJEditPhotoVC.h"
#import "UIImageView+LBBlurredImage.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import "BANetManager.h"
#import "FTPopOverMenu.h"
#import "YJPhotoLsitModel.h"
#import "YJPageModel.h"
#import "YJAddPhotoVC.h"
#import "YJReplaceNameVC.h"
#import "SDPhotoBrowser.h"

static CGFloat imageH = 200;
static CGFloat navH = 64;

@interface YJEditPhotoVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,SDPhotoBrowserDelegate>{
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    CGFloat _itemWH;
    CGFloat _margin;
    SDPhotoBrowser *photoBrowser;
    
//    NSMutableArray *_photoList;
    
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;


//@property (strong, nonatomic) UITableView *collectionView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *albumName; //相册名称
@property (nonatomic, strong) UIImage *shadowImage;

@property (nonatomic, strong) NSMutableArray  *photoLsitArr;//内容列表

@property (nonatomic, strong) YJPageModel *pageModle;
@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation YJEditPhotoVC

- (NSMutableArray *)modelsArray{
    
    if (_modelsArray == nil) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}


- (NSMutableArray *)photoLsitArr{
    if (_photoLsitArr == nil) {
        _photoLsitArr = [NSMutableArray array];
    }
    
    return _photoLsitArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = BackGray;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:nil];
;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(onNavButtonTapped:event:) title:@"编辑" titleColor:[UIColor whiteColor] font:AdaptedWidth(16)];

    //加载布局
    [self configCollectionView];

    
    
    self.shadowImage = self.navigationController.navigationBar.shadowImage;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    [self changeNavAlphaWithConnentOffset:offsetY];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.shadowImage = self.shadowImage;
    self.navigationController.navigationBar.translucent = YES;

}

- (void)back{
    
    
    self.navigationController.navigationBar.translucent = YES;
    UIViewController *vc = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
    
    
}

//- (void)finsh{
//    XXLog(@"编辑");
//}


#pragma mark - 更改导航栏透明状态
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < - imageH) {
        XXLog(@"开始改变");
        CGRect f = self.headerView.frame;
        f.origin.y = offsetY - 5;
        f.size.height =  -offsetY - 5;
        self.headerView.frame = f;
        XXLog(@"%f",offsetY);
//        if (offsetY == -200.500000) {
//            self.headerView.frame = CGRectMake(0, - imageH - 5, screen_width, imageH - 5);
//        }

    }
    
    [self changeNavAlphaWithConnentOffset:offsetY];
}

-(void)changeNavAlphaWithConnentOffset:(CGFloat)offsetY
{
    UIColor *color = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
//    XXLog(@"%f",offsetY);

    if (offsetY > - 150) {
      
        XXLog(@"渐渐不透明");
        CGFloat alpha = MIN(1, 1 - ((-navH - offsetY) / navH));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        self.title = @"个人主页";
        
    }
    else {
        XXLog(@"渐渐透明");
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    //加载网络图片
    [self getPhotoLsit];

    
    // Do any additional setup after loading the view.
}

- (void)getPhotoLsit{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.albumId forKey:@"albumId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/albumPic/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.photoLsitArr = [YJPhotoLsitModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"albumPicList"]];
            
            self.pageModle = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryAlbumPic"][@"page"]];
            
            [self.modelsArray removeAllObjects];
            
            for (YJPhotoLsitModel *model in self.photoLsitArr) {
                
                NSString *str = model.url;
                [self.modelsArray addObject:str];
            }
            
            YJPhotoLsitModel *model = self.photoLsitArr.firstObject;
            [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"bg2"]];
            [self.headerView setImageToBlur:self.headerView.image
                                 blurRadius:5
                            completionBlock:^(){
                            }];
            
            [self.collectionView reloadData];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {

            }];
            alert.sure_btnTitleColor = TextColor;
            alert.sure_btnTitle = @"好的";
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)onNavButtonTapped:(UIBarButtonItem *)sender event:(UIEvent *)event
{

    [FTPopOverMenu showFromEvent:event withMenu:@[@"修改名称",@"删除相册"] doneBlock:^(NSInteger selectedIndex) {
        XXLog(@"点击了第%ld个",selectedIndex);
        
        if (selectedIndex == 0) {
            YJReplaceNameVC *vc = [[YJReplaceNameVC alloc]init];
            vc.albumId = self.albumId;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"是否删除该相册" alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                if (index == 1) {
                    [self removeAlbum];
                }
            }];
            alert.sure_btnTitleColor = TextColor;
            alert.sure_btnTitle = @"删除";
            [alert show];
        }
        
    } dismissBlock:^{
        
    }];
    
}


#pragma mark - 删除相册
- (void)removeAlbum{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.albumId forKey:@"id"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/album/delete",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"删除相册成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 4 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.tz_width, self.view.tz_height) collectionViewLayout:layout];
    //    _collectionView = [[UICollectionView alloc]init];
    //    _collectionView.collectionViewLayout = layout;
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(imageH, 0, 0, 0);
//    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    //    self.collectionView.sd_layout.leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).topSpaceToView(self.textView,10).bottomSpaceToView(self.view,10);
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.frame = CGRectMake(0, - 205, screen_width, 195);
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.corPic] placeholderImage:[UIImage imageNamed:@"bg2"]];
    [self.headerView setImageToBlur:self.headerView.image
                         blurRadius:5
                    completionBlock:^(){
                    }];
    [self.collectionView addSubview:self.headerView];
    [self.collectionView insertSubview:self.headerView atIndex:0];
    self.headerView.userInteractionEnabled = YES;
    
    
    self.albumName = [[UILabel alloc]init];
    self.albumName.text = @"相册名称";
    self.albumName.textColor = [UIColor whiteColor];
    self.albumName.font = [UIFont systemFontOfSize:AdaptedWidth(17.0)];
    self.albumName.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.albumName];
    self.albumName.sd_layout.centerYEqualToView(self.headerView).centerXEqualToView(self.headerView).widthIs(200).heightIs(20);
    self.albumName.text = self.album;


    
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoLsitArr.count + 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == self.photoLsitArr.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        
            YJPhotoLsitModel *model = self.photoLsitArr[indexPath.row];
            cell.gifLable.hidden = YES;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"bg2"]];
//            cell.asset = _selectedAssets[indexPath.row];
            cell.deleteBtn.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.photoLsitArr.count) {
     
        YJAddPhotoVC *vc = [[YJAddPhotoVC alloc]init];
        vc.albumId = self.albumId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = indexPath.row;
        photoBrowser.imageCount = self.modelsArray.count;
        photoBrowser.sourceImagesContainerView = self.collectionView;

        
        [photoBrowser show];
        
    }
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    TZTestCell *cell = (TZTestCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    return cell.imageView.image;
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.modelsArray[index];
    return [NSURL URLWithString:urlStr];
}

- (void)indexPath:(NSInteger)index{
    
    YJPhotoLsitModel *model = self.photoLsitArr[index];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:model.ID forKey:@"id"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/albumPic/delete",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"删除相册成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];

            [photoBrowser removeFromSuperview];
            [self getPhotoLsit];
            
            
        }else{
           
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            alert.sure_btnTitle = @"好的";
            [alert show];
  
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
