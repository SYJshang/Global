//
//  YJSetUserController.m
//  全球向导
//
//  Created by SYJ on 2016/12/16.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSetUserController.h"
#import "YJEditPhotoCell.h"
#import "YJTimeCell.h"
#import "YJSetUserInfoVC.h"
#import "AFNetworking.h"
#import "YJUsreInfoModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface YJSetUserController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *imgId;

@property (nonatomic, strong) YJUsreInfoModel *userModel;

@end

@implementation YJSetUserController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"提交" titleColor:TextColor font:AdaptedWidth(16)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"编辑用户信息" font:19.0];
    //加载用户信息
}

- (void)finsh{
    
    XXLog(@"提交信息");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Set the label text.
    hud.label.text = NSLocalizedString(@"提交信息...", @"HUD loading title");
    hud.backgroundView.color = [UIColor blackColor];

    if (self.imgId) {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:self.nickName forKey:@"nickName"];
            //    [parameter setObject:@"json" forKey:@"format"];
            int headreId = [self.imgId intValue];
            NSNumber *heaId = [NSNumber numberWithInt:headreId];
            [parameter setObject:heaId forKey:@"headPicId"];
            XXLog(@"%@",parameter);
            [WBHttpTool Post:[NSString stringWithFormat:@"%@/user/update",BaseUrl] parameters:parameter success:^(id responseObject) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                XXLog(@"%@",dict);
                NSString *code = dict[@"code"];
                
                if ([code isEqualToString:@"1"]) {
                    
                    sleep(1);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [[UIImage imageNamed:@"smile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud.customView = imageView;
                        hud.mode = MBProgressHUDModeCustomView;
                        hud.label.text = NSLocalizedString(@"完成", @"HUD completed title");
                        [hud hideAnimated:YES];
                    });

                }else{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:dict[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:action1];
                    [alertVC addAction:action2];
                    [self presentViewController:alertVC animated:YES completion:nil];
                    
                    
                }
                
                
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
            }];

           
        });
        
        
        
    }else{
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:self.nickName forKey:@"nickName"];
            //    [parameter setObject:@"json" forKey:@"format"];
            long headreId = self.userModel.headPicId;
            //         = [self.imgId intValue];
            NSNumber *heaId = [NSNumber numberWithLong:headreId];
            [parameter setObject:heaId forKey:@"headPicId"];
            XXLog(@"%@",parameter);
            [WBHttpTool Post:[NSString stringWithFormat:@"%@/user/update",BaseUrl] parameters:parameter success:^(id responseObject) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                XXLog(@"%@",dict);
                
                NSString *code = dict[@"code"];
                if ([code isEqualToString:@"1"]) {
                    
                    sleep(1);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [[UIImage imageNamed:@"smile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud.customView = imageView;
                        hud.mode = MBProgressHUDModeCustomView;
                        hud.label.text = NSLocalizedString(@"完成", @"HUD completed title");
                        [hud hideAnimated:YES];
                    });
                    
            }else{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:dict[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:action1];
                    [alertVC addAction:action2];
                    [self presentViewController:alertVC animated:YES completion:nil];
                    
                    
                }
                
            } failure:^(NSError *error) {
                [hud hideAnimated:YES];
                XXLog(@"error >>>>%@",error);
            }];
           
        });
        
        
     
    }
    
    
  }

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
   
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
   NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    //获取用户信息
    if (userInfo) {
        self.userModel = [YJUsreInfoModel mj_objectWithKeyValues:userInfo];
    }
    
    [self.tableView registerClass:[YJEditPhotoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJTimeCell class] forCellReuseIdentifier:@"cell1"];

    
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        return 60;
//    }
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        YJEditPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.title.text = @"选择头像";
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
        return cell;
    }
    
    YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[YJTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    switch (indexPath.row) {
            
        case 1:
            
            cell.title.text = @"昵称";
            cell.time.text = self.userModel.nickName;
            self.nickName = cell.time.text;
            
            break;
        case 2:
            cell.title.text = @"手机号";
            cell.time.text = self.userModel.mobile;
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self setup];
    }else if (indexPath.row == 1){
        YJSetUserInfoVC *vc = [[YJSetUserInfoVC alloc]init];
        vc.nickName = ^(NSString *nick){
            
            self.nickName = nick;
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            YJTimeCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.time.text = self.nickName;
            XXLog(@"%@",nick);
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号不能更改" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alertVC addAction:action1];
//        [alertVC addAction:action2];
//        [self presentViewController:alertVC animated:YES completion:nil];

        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"手机号暂时不能更改" alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
        }];
        alert.sure_btnTitleColor = TextColor;
        alert.sure_btnTitle = @"确定";
        [alert show];
        
    }
    
}


//选择照片
- (void)setup
{
    UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //从相机选取
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    //从相机选取
    UIAlertAction *camera=[UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancl=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [aler addAction:cancl];
    [aler addAction:album];
    [aler addAction:camera];
    [self presentViewController:aler animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    self.imgData = UIImageJPEGRepresentation(image, 1);
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    YJEditPhotoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.icon.image = image;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Set the label text.
    hud.label.text = NSLocalizedString(@"正在上传图片...", @"HUD loading title");

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:@"json" forKey:@"format"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        
        [manager POST:[NSString stringWithFormat:@"%@/uploadC?dir=image",BaseUrl] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //把图片转换为二进制流
            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
            //按照表单格式把二进制文件写入formData表单
            [formData appendPartWithFileData:imageData name:@"upload" fileName:[NSString stringWithFormat:@"%@.png",@"test"] mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"图片上传进度%f",uploadProgress.fractionCompleted);
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *datas = (NSDictionary *)responseObject ;
            XXLog(@"%@",datas);
            
            NSString *code = datas[@"code"];
            
            if ([code isEqualToString:@"1"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imgId = datas[@"data"][@"id"];
                    XXLog(@"id   ===%@",self.imgId);
                    
                   
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = NSLocalizedString(@"上传完成", @"HUD completed title");
                    [hud hideAnimated:YES];

                });
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:datas[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                        
                    }];
                    alert.sure_btnTitleColor = TextColor;
                    alert.sure_btnTitle = @"确定";
                    [alert show];
                });
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                NSLog(@"%@",error);
            
            UIImage *image = [[UIImage imageNamed:@"photo_delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hud.customView = imageView;
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.text = NSLocalizedString(@"失败", @"HUD completed title");
            [hud hideAnimated:YES];
                 
             });
        }];

    });
    
    
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
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
