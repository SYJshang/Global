
//
//  YJEvaluationController.m
//  全球向导
//
//  Created by SYJ on 2016/12/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJEvaluationController.h"
#import "UITextView+YLTextView.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "BANetManager.h"



@interface YJEvaluationController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextViewDelegate>

{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}


//头像
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UITextView *textView;

//相册
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSString *photoID; //图片上传id

@property (nonatomic, strong) YJDIYButton *badBtn;
@property (nonatomic, strong) YJDIYButton *norBtn;
@property (nonatomic, strong) YJDIYButton *goodBtn;

@end

@implementation YJEvaluationController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLaoutView];
    
}

- (void)setLaoutView{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = BackGray;
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"评价" font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *right = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"完成" titleColor:TextColor font:16.0];
    self.navigationItem.rightBarButtonItem = right;

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)finsh{
    
    [self eveaData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGray;
    [self setArtile];
    
    self.photoID = @"";
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];

    // Do any additional setup after loading the view.
}


//设置上边头像及输入文字信息布局
- (void)setArtile{
    
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
    [self.view addSubview:self.icon];
    self.icon.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,70).widthIs(80).heightIs(80);
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
    NSDictionary *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (data) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:data[@"headUrl"]] placeholderImage:[UIImage imageNamed:@"head"]];
    }
    
    
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"向导的服务打分";
    label.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    label.sd_layout.leftSpaceToView(self.icon, 10).topSpaceToView(self.view, 85).heightIs(20).rightSpaceToView(self.view, 10);
    
    
    self.badBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"bad" selectedImageName:@"y_bad" title:@"差评" andBlock:^{
        
        self.norBtn.selected = NO;
        self.goodBtn.selected = NO;
        self.badBtn.selected = YES;
        
    }];
    [self.view addSubview:self.badBtn];
    self.badBtn.sd_layout.leftSpaceToView(self.icon, 12).topSpaceToView(label, 10).widthIs(45).heightIs(20);
    
    self.norBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"normal" selectedImageName:@"y_normal" title:@"一般" andBlock:^{
        
        self.norBtn.selected = YES;
        self.goodBtn.selected = NO;
        self.badBtn.selected = NO;
        
    }];
    [self.view addSubview:self.norBtn];
    self.norBtn.sd_layout.leftSpaceToView(self.badBtn, 25).topSpaceToView(label, 10).widthIs(45).heightIs(20);
    
    self.goodBtn = [YJDIYButton buttonWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"good" selectedImageName:@"y_good" title:@"好评" andBlock:^{
        
        self.norBtn.selected = NO;
        self.goodBtn.selected = YES;
        self.badBtn.selected = NO;
        
    }];
    [self.view addSubview:self.goodBtn];
    self.goodBtn.sd_layout.leftSpaceToView(self.norBtn, 25).topSpaceToView(label, 10).widthIs(45).heightIs(20);
    
    
    self.textView = [[UITextView alloc]init];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
//    self.textView.backgroundColor
    self.textView.sd_layout.leftSpaceToView(self.view,10).topSpaceToView(self.view,155).rightSpaceToView(self.view,10).heightIs(100);
    self.textView.placeholder = @"亲~~ 在这里你可以写下对向导的评价那~~";
    self.textView.limitLength = @200;
    self.textView.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.textView.textColor = [UIColor colorWithRed:70.0 / 255.0 green:70.0 / 255.0 blue:70.0 / 255.0 alpha:1.0];

}
    
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - 提交评论信息
- (void)eveaData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.ID forKey:@"orderId"];
    if (self.photoID) {
        [parameter setObject:self.photoID forKey:@"picIds"];
    }
    [parameter setObject:self.textView.text forKey:@"eva"];
    
    if (self.badBtn.selected == YES) {
        [parameter setObject:@"3" forKey:@"evaValue"];
    }else if (self.norBtn.selected == YES){
        [parameter setObject:@"2" forKey:@"evaValue"];
    }else if (self.goodBtn.selected == YES){
        [parameter setObject:@"1" forKey:@"evaValue"];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelColor = [UIColor whiteColor];
        hud.color = [UIColor blackColor];
        hud.labelText = NSLocalizedString(@"请选择对向导的评价!", @"HUD message title");
        [hud hide:YES afterDelay:2.0];
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myEva/evaByOrderId",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"上传评论成功!", @"HUD message title");
            [hud hide:YES afterDelay:2.0];
            [self.navigationController popViewControllerAnimated:YES];

        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            [self.view endEditing:YES];
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            [alert show];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)PostImage{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"json" forKey:@"format"];
    //    [parameter setObject:@"" forKey:@""];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelColor = [UIColor whiteColor];
    hud.color = [UIColor blackColor];
    hud.labelText = NSLocalizedString(@"正在上传图片...", @"HUD message title");
    
    [BANetManager ba_uploadImageWithUrlString:[NSString stringWithFormat:@"%@/uploadCM?dir=image",BaseUrl] parameters:parameter imageArray:_selectedPhotos fileName:[NSString stringWithFormat:@"%ld.png",_selectedPhotos.count] successBlock:^(id response) {
        
        NSDictionary *dict = response;
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            //            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"上传图片成功！", @"HUD message title");
            [hud hide:YES afterDelay:2.0];
            
            NSMutableArray *arr = dict[@"data"];
            for (NSDictionary *photo in arr) {
                
                NSString *ID = photo[@"id"];
                self.photoID = [NSString stringWithFormat:@"%@%@,",self.photoID,ID];
                XXLog(@"%@",self.photoID);
                
            }
            
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            [alert show];
        }
        
    } failurBlock:^(NSError *error) {
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"上传图片失败" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
        }];
        [alert show];
        
    } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    [BANetManager ba_uploadImageWithUrlString:nil parameters:nil imageArray:nil fileName:nil successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}




#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}



- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 265, self.view.tz_width, self.view.tz_height - 265) collectionViewLayout:layout];
    //    _collectionView = [[UICollectionView alloc]init];
    //    _collectionView.collectionViewLayout = layout;
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    //    self.collectionView.sd_layout.leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).topSpaceToView(self.textView,10).bottomSpaceToView(self.view,10);
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"add_photo"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        //#pragma clang diagnostic pop
        //            [sheet showInView:self.view];
        
        [self pushImagePickerController];
        
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
#pragma clang diagnostic pop
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}


#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    int maxCount = 9;
    
    //加载相册初始化
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    if (maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    //    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    //    imagePickerVc.allowCrop = YES;
    //    imagePickerVc.needCircleCrop = YES;
    
    //    imagePickerVc.photoWidth = 1000;
    //    imagePickerVc.photoPreviewMaxWidth = 800;
    
    // 4. 照片排列按修改时间升序
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    //     imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
        }
    }
}

//- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([type isEqualToString:@"public.image"]) {
//        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//        //        tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
//        [tzImagePickerVc showProgressHUD];
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        // save photo and get asset / 保存图片，获取到asset
//        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
//            if (error) {
//                [tzImagePickerVc hideProgressHUD];
//            } else {
//                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
//                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }
//                        [_selectedAssets addObject:assetModel.asset];
//                        [_selectedPhotos addObject:image];
//                        [_collectionView reloadData];
//                    }];
//                }];
//            }
//        }];
//    }
//}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    if ([picker isKindOfClass:[UIImagePickerController class]]) {
//        [picker dismissViewControllerAnimated:YES completion:nil];
//    }
//}
//
//#pragma mark - UIActionSheetDelegate
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//#pragma clang diagnostic pop
//    if (buttonIndex == 0) { // take photo / 去拍照
//        [self takePhoto];
//    } else if (buttonIndex == 1) {
//        [self pushImagePickerController];
//    }
//}

#pragma mark - UIAlertViewDelegate



#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    [self PostImage];
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}




#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
