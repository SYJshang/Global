//
//  YJPhoneNumCell.h
//  全球向导
//
//  Created by SYJ on 2016/11/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^textBlock)(NSString *text);//定义block


@interface YJPhoneNumCell : UITableViewCell<UITextFieldDelegate>



//
@property (nonatomic, strong) UILabel *phoneNum;

//输入电话
@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, copy) textBlock text;


@end
