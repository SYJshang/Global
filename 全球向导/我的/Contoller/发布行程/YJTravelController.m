
//
//  YJTravelController.m
//  全球向导
//
//  Created by SYJ on 2016/12/2.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTravelController.h"
#import "UINavigationBar+Awesome.h"
#import "YJIssueTitleCell.h"
#import "UIImageView+LBBlurredImage.h"

static CGFloat imageH = 200;
static CGFloat navH = 64;

@interface YJTravelController ()<UITableViewDelegate,UITableViewDataSource,SGActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImage *shadowImage;

@property (nonatomic, strong) NSMutableArray  *contentLsitArr;//内容列表



@end

@implementation YJTravelController

- (NSMutableArray *)contentLsitArr{
    if (_contentLsitArr == nil) {
        _contentLsitArr = [NSMutableArray array];
    }
    
    return _contentLsitArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
   
    
    
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:nil];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"发布" titleColor:TextColor font:AdaptedWidth(16)];
//    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"发布行程" font:19.0];
    
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
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BackGray;
    self.tableView.contentInset = UIEdgeInsetsMake(imageH, 0, 0, 0);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YJIssueTitleCell class] forCellReuseIdentifier:@"title"];
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.frame = CGRectMake(0, - imageH, screen_width, imageH);
    
//    self.headerView.image = [UIImage imageNamed:@"bg2"];
    [self.headerView setImageToBlur:[UIImage imageNamed:@"bg2"]
                        blurRadius:5
                   completionBlock:^(){
                   }];
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.headerView];
    [self.tableView insertSubview:self.headerView atIndex:0];
    self.headerView.userInteractionEnabled = YES;
    
    YJDIYButton *btn = [YJDIYButton buttonWithtitle:@"更换封面" Block:^{
        XXLog(@"更换封面");
        SGActionSheet *sheet = [[SGActionSheet alloc]initWithTitle:@"更换封面" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册",@"相机"]];
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
    
    YJDIYButton *backBtn = [YJDIYButton buttonWithFrame:CGRectMake(10, 25, 10, 15) imageName:@"back" andBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [self.headerView addSubview:backBtn];
    
    YJDIYButton *finsh = [YJDIYButton buttonWithtitle:@"发布" Block:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [finsh setTitleColor:TextColor forState:UIControlStateNormal];
    finsh.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    [self.headerView addSubview:finsh];
    finsh.sd_layout.rightSpaceToView(self.headerView,10).topSpaceToView(self.headerView,25).widthIs(40).heightIs(16);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"发布行程";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:AdaptedWidth(17.0)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:label];
    label.sd_layout.topSpaceToView(self.headerView,25).centerXEqualToView(self.headerView).widthIs(100).heightIs(20);
    
}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)finsh{
    
    XXLog(@"发布");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return self.contentLsitArr.count + 1;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 100;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YJIssueTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (indexPath.row == 0) {
            cell.textView.placeholder = @"输入标题（20字）";
            cell.textView.limitLength = @20;
        }else if (indexPath.row == 1){
            cell.textView.placeholder = @"输入简介（100字）";
            cell.textView.limitLength = @100;
        }
        return cell;

    }
    
    
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
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < -imageH) {
        XXLog(@"开始改变");
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
        XXLog(@"渐渐不透明");
        CGFloat alpha = MIN(1, 1 - ((-navH * 2 + navH - offsetY) / navH));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        self.title = @"个人主页";
    }
    else {
        XXLog(@"渐渐透明");
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        self.title = @"";
    }
}


#pragma mark - actionSheet delegate
- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath{
    
    if (indexPath == 0) {
        XXLog(@"打开相册");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }else{
        XXLog(@"打开相机");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData  *imgData = UIImageJPEGRepresentation(image, 1);
    [self.headerView setImageToBlur:image
                         blurRadius:5
                    completionBlock:^(){
                    }];
    // Set the label text.
    
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)blur:(UIImage *)theImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}




@end
