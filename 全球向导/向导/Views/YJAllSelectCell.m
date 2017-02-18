//
//  YJAllSelectCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAllSelectCell.h"
#import "YJSelectLab.h"
#import "NSNotification+Extension.h"
#import "YJSexModel.h"
#import "YJGuideTypeModel.h"
#import "YJPriceModel.h"

@interface MCELLSelect()

@end

@implementation MCELLSelect
- (instancetype)init{
    
    self  = [super init];
    if (self) {
        
        self.selectArr = [NSMutableArray array];
    }
    
    return self;
}


@end

@interface YJAllSelectCell ()<SeleLableDele>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation YJAllSelectCell

- (void)onint{
    self.titleArray = [NSMutableArray array];
    self.titleLabel = [[UILabel alloc]init];
    
    [self addSubview:self.titleLabel];
    
    [self observeNotification:@"CCC"];
    
}
- (void)setSelctedBlock:(Block)block{
    
    self.block = block;
}
- (void)handleNotification:(NSNotification *)notification{
    if ([notification is:@"CCC"]) {
        
        self.block(self.titleArray);
        
    }
    
    [self.titleArray removeAllObjects];
}
- (void)updateData{
    self.arr = [NSMutableArray array];
    self.titleLabel.text = self.data.title;
    self.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    if (self.data.arrLabel > 0) {
        for (int i = 0; i < self.data.arrLabel.count; i++) {
            
            YJSelectLab *lable = [[YJSelectLab alloc]init];
            lable.text = [self.data.arrLabel[i] name];
            lable.ID = [self.data.arrLabel[i] valueId];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor blackColor];
            lable.tag = 10000 + i;
            if (lable.tag == 10000) {
                lable.isCLick = YES;
            }
            
            lable.clinicDele = self;
            [self addSubview:lable];
            [self.arr addObject:lable];
        }
    }
    [self refresh];
}



- (void)clinicTitle:(NSString *)title withClinicChoose:(BOOL)isChoose;
{
    switch (self.data.seleType) {
            
        case CL_SeleType_Radio:
            
            [self handleInRadioIndex:title];
            
            break;
            
        case CL_SeleType_CheckBoxes:
            
            [self handleInCheckBoxIndex:title withClinicChoose:isChoose];
            
            break;
            
            
        default:
            break;
    }
    
    
    
    
    
    
    for (int i = 0 ;  i < self.data.arrLabel.count; i ++) {
        
        YJSelectLab *lable = [self viewWithTag:(i + 10000)];
        
        if ([self.titleArray containsObject:[[self.data.arrLabel objectAtIndex:i]valueId]]) {
            
            lable.isCLick = YES;
            
            continue;
        }
        lable.isCLick = NO;
        
    }
    
}

#pragma mark ---  Radio处理
-(void)handleInRadioIndex:(NSString *)titleName
{
    [self changeTheBorderToNormalInRadio];
    
    [self addTheLableInStoreArray:titleName];
}

-(void)changeTheBorderToNormalInRadio
{
    
    [self.titleArray removeAllObjects];
}


-(void)addTheLableInStoreArray:(NSString *)titleName
{
    
    
    [self.titleArray addObject:titleName];
    XXLog(@"%@",self.titleArray);

}



#pragma mark ---  CheckBox 处理
-(void)handleInCheckBoxIndex:(NSString *)titleName withClinicChoose:(BOOL)isChoose
{
    
    //如果是选择,加入数组
    if(isChoose)
    {
        //判断是不是重复选择
        BOOL isValue = [self.titleArray containsObject:titleName];
        
        if (isValue) {
            return;
        }
        
        
        [self.titleArray addObject:titleName];
        
    }
    else
    {
        [self.titleArray removeObject:titleName];
    }
    
}


- (void)refresh{
    //    [super layoutSubviews];
    CGRect r = self.titleLabel.frame;
    r.origin.x= 10;
    r.origin.y = 5;
    r.size.width = 150;
    r.size.height = 30;
    self.titleLabel.frame = r;
   
    CGRect r0;
    r0.size.width = (screen_width - 50) / 4;
    r0.size.height = 30;
    int a = 0;
    
    if (self.arr > 0) {
        
        
        
        for(int i = 0;i < self.arr.count; i ++) {
            
            UILabel *la =  (UILabel *)self.arr[i];
            
            CGRect r = la.frame;
            if ( CGRectGetMaxX(r0) + 10 + r0.size.width > screen_width) {
                r.origin.y = CGRectGetMaxY(r0) + 5;
                r.origin.x = 10;
                a++;
            }else {
                if (i==0) {
                    r.origin.y = 5+40;
                    r.origin.x = 10;
                    
                }else {
                    r.origin.x = CGRectGetMaxX(r0)+10;
                    r.origin.y = r0.origin.y;
                    
                }
                
                
                
            }
            
            r.size.width = r0.size.width;
            r.size.height = 30;
            la.frame = r;
            r0 = r;
            
        }
        
        self.data.cellHeight = CGRectGetMaxY(r0)+10;
    }
}


@end
