
//
//  YJTableCollectionCell.m
//  全球向导
//
//  Created by SYJ on 2017/4/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJTableCollectionCell.h"
#import "YJImgBtnCell.h"
#import "XRWaterfallLayout.h"

#define Kwidths  ([UIScreen mainScreen].bounds.size.width / 3)

@interface YJTableCollectionCell ()<UICollectionViewDataSource, XRWaterfallLayoutDelegate,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collection;

@end


@implementation YJTableCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:3];
        //设置各属性的值
        waterfall.rowSpacing = 0;
        waterfall.columnSpacing = 0;
        waterfall.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
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
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_width,screen_width) collectionViewLayout:waterfall];
        [self.collection registerClass:[YJImgBtnCell class] forCellWithReuseIdentifier:@"cell"];
        self.collection.dataSource = self;
        self.collection.delegate = self;
        
        self.collection.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collection];

        
    }
    
    return self;
}


//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    
    //    int y = (arc4random() % 80) + 240;
    
    return Kwidths;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    NSMutableArray *listCount = [NSMutableArray array];
    //    for (int i = 0; i < self.guideList.count; i ++) {
    //        YJGuideModel *model = self.guideList[i];
    //        [listCount addObject:model];
    //    }
    
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *imgArr = @[@"guide_center",@"sign",@"attendance_score",@"order",@"evaluate",@"my_release",@"release",@"collection",@"call_center"];
    NSArray *nameArr = @[@"向导中心",@"签到",@"积分",@"订单",@"评价",@"我的发布",@"发布",@"收藏",@"客服中心"];
    YJImgBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YJImgBtnCell alloc]init];
    }
    
//    cell.backgroundColor = [UIColor grayColor];
    
    cell.img.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.name.text = nameArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(index:)]) {
        [self.delegate index:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Kwidths, Kwidths);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
