//
//  YJSelectLab.m
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSelectLab.h"

@implementation YJSelectLab

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth =  1;
        self.backgroundColor = [UIColor whiteColor];
        [self addTapAction];
        self.isCLick = NO;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    }
    return self;
}

-(void)addTapAction
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle)];
    [self addGestureRecognizer:tap];
    
}

-(void)setIsCLick:(BOOL)isCLick
{
    _isCLick = isCLick;
    
    if(isCLick)
    {
        [self setHighlightedStatus];
    }
    else
    {
        [self setNormalStatus];
    }
    
}

-(void)tapHandle
{
    
    //点击取消时
    if(self.isCLick == YES)
    {
        [self setNormalStatus];
    }
    
    //点击选中时
    else
    {
        [self setHighlightedStatus];
    }
    
    self.isCLick = !self.isCLick;
    
    [self.clinicDele clinicTitle:self.ID withClinicChoose:self.isCLick];
    
}

-(void)setNormalStatus
{
    
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];

    self.layer.borderColor =  [[UIColor lightGrayColor] CGColor];
    
}
-(void)setHighlightedStatus
{
    
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = TextColor;
    
    self.layer.borderColor =  [BackGroundColor CGColor];
    ;
    
    
}


@end
