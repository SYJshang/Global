//
//  YJTextViewController.h
//  全球向导
//
//  Created by SYJ on 2016/11/15.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ablock)(NSString *str);

@interface YJTextViewController : UIViewController



@property (nonatomic, strong) UITextView *textView;
//定义传值的blcok块
@property (nonatomic, copy) ablock block;


@end
