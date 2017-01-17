
//
//  YJDIYButton.m
//  全球向导
//
//  Created by SYJ on 2017/1/10.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJDIYButton.h"

@interface YJDIYButton()

//注意：声明block类型使用copy
@property(nonatomic,copy)buttonBlock tempBlock;

@end

@implementation YJDIYButton

+(YJDIYButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(buttonBlock)myBlock{
    
    YJDIYButton *button = [YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame=frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.tempBlock = myBlock;
    
    return button;
    
}
+(YJDIYButton *)buttonWithtitle:(NSString *)title Block:(buttonBlock)block{
    
    YJDIYButton *button=[YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame=CGRectMake(0, 0, 0, 0);
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.tempBlock=block;
    
    return button;
    
}

+(YJDIYButton *)imageName:(NSString *)imageName Block:(buttonBlock)block{
    
    
    YJDIYButton *button=[YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame=CGRectMake(0, 0, 0, 0);
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    button.tempBlock=block;
    
    return button;
}


+(YJDIYButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title selectedTitle:(NSString *)selectedTitle andBlock:(buttonBlock)myBlock{
    
    YJDIYButton *button = [YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame=frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.tempBlock=myBlock;
    
    return button;
    
}
+(YJDIYButton *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imageName andBlock:(buttonBlock)myBlock{
    
    YJDIYButton *button=[YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame=frame;
    
    //[button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image=[UIImage imageNamed:imageName];
    
    // image=[image stretchableImageWithLeftCapWidth:20 topCapHeight:0];//拉
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.tempBlock=myBlock;
    
    return button;
    
}
+(YJDIYButton *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName andBlock:(buttonBlock)myBlock{
    
    YJDIYButton *button = [YJDIYButton buttonWithFrame:frame imageName:imageName andBlock:myBlock];
    
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    return button;
    
}

+ (YJDIYButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName Block:(buttonBlock)block{
    
    YJDIYButton *button = [YJDIYButton buttonWithType:UIButtonTypeCustom];//自定义
    
    button.frame = frame;
    
    //[button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(buttonBlockClick:) forControlEvents:UIControlEventTouchUpInside];

    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.tempBlock = block;

    
    return button;
}

-(void)buttonBlockClick:(YJDIYButton *)button{
    
    //调用block变量
    
    if (self.tempBlock) {//判断是否实现Block
        
        self.tempBlock();
        
    }
    
}


@end





