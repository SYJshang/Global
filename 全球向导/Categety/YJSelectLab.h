//
//  YJSelectLab.h
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SeleLableDele <NSObject>

-(void)clinicTitle:(NSString *)title withClinicChoose:(BOOL)isChoose;

@end


@interface YJSelectLab : UILabel

@property (nonatomic,assign) BOOL isCLick;

@property (nonatomic,assign) id<SeleLableDele> clinicDele;

@end
