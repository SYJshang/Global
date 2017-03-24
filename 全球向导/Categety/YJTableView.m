//
//  YJTableView.m
//  全球向导
//
//  Created by SYJ on 2017/3/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJTableView.h"

@implementation YJTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
        return self;
    }else{
        
        return view;
 
    }
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
