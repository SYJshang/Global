//
//  DNPageView.m
//  DNAppDemo
//
//  Created by mainone on 16/4/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNPageView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//手机屏幕
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)


//引导图的页数
static NSInteger const pageNum = 3;

@interface DNPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton      *doneButton;

@property (nonatomic, strong) DNPageDismiss dismissBlock;

@end

@implementation DNPageView

+ (DNPageView *)sharePageView {
    static DNPageView *pageInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageInstance = [[DNPageView alloc] init];
    });
    return pageInstance;
}

- (void)initPageViewToView:(UIView *)view dismiss:(DNPageDismiss)dismiss{
    self.dismissBlock = [dismiss copy];
    self.frame = view.bounds;
    self.backgroundColor = [UIColor whiteColor];
    [view addSubview:self];
    
    [self createScrollView];
//    [self createPageControl];
}

//设置pageControl
- (void)createPageControl {
    self.isPageControl = YES;
    self.pageControl.currentPage = 0;
}

//设置scrollview
- (void)createScrollView {
    self.scrollView.backgroundColor = [UIColor whiteColor];
    NSArray *imageNameArr = @[@"01", @"02", @"3"];
    if (iphone5x_4_0) {
        imageNameArr = @[@"01", @"02", @"3"];
    }else if (iphone6_4_7 || iphone6Plus_5_5) {
        imageNameArr = @[@"01", @"02", @"3"];
    }
    
   [imageNameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
       NSString *path = [[NSBundle mainBundle] pathForResource:obj ofType:@"png"];
       imageView.image = [UIImage imageWithContentsOfFile:path];
       imageView.contentMode = UIViewContentModeScaleToFill;
       imageView.userInteractionEnabled = YES;
       [self.scrollView addSubview:imageView];
       if (idx == pageNum-1) {//最后一张上添加进入按钮
           [imageView addSubview:self.doneButton];
       }
   }];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (pageNum-1)) {
        CGFloat alpha = 1- (scrollView.contentOffset.x - SCREEN_WIDTH * (pageNum-1)) / SCREEN_WIDTH;
        self.alpha = alpha;
        self.scrollView.alpha = alpha;
        if (alpha == 0) {
            [self removeFromSuperview];
            if (self.dismissBlock) {
                self.dismissBlock();
                self.dismissBlock = nil;
            }
        }
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView.backgroundColor = [UIColor whiteColor];
    }
}

//- (void)setIsPageControl:(BOOL)isPageControl {
//    if (!isPageControl) {
//        self.pageControl.hidden = YES;
//    }
//}

#pragma mark - method
- (void)doneBtnClick {
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0;
        self.scrollView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock();
            self.dismissBlock = nil;
        }
    }];
}

#pragma mark - 初始化
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled                  = YES;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces                        = YES;
        _scrollView.userInteractionEnabled         = YES;
        _scrollView.clipsToBounds                  = NO;
        _scrollView.scrollEnabled                  = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *(pageNum+1), SCREEN_HEIGHT);
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

//-(UIPageControl *)pageControl {
//    if (!_pageControl) {
//        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 10)];
//        [_pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
//        [_pageControl setPageIndicatorTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.2]];
//        [self.pageControl setNumberOfPages:pageNum];
//        [self addSubview:_pageControl];
//    }
//    return _pageControl;
//}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_doneButton setTitle:@"立即进入" forState:UIControlStateNormal];
        _doneButton.frame = CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH, 80);
        [_doneButton addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}


@end
