//
//  YJAllSelectCell.h
//  全球向导
//
//  Created by SYJ on 2016/12/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    CL_SeleType_Radio  = 0,
    
    CL_SeleType_CheckBoxes,
    
} CL_SeleType ;

@interface MCELLSelect : NSObject
@property (nonatomic,assign)CGFloat baseheight;
@property (nonatomic,strong)NSMutableArray *arrLabel;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSMutableArray *selectArr;
@property (nonatomic,assign) CL_SeleType seleType;
@property (nonatomic,assign)CGFloat cellHeight;
@end

typedef void (^Block)(NSArray *arr );

@interface YJAllSelectCell : UITableViewCell
@property (nonatomic,strong)MCELLSelect *data;

@property (nonatomic,strong) NSMutableArray *titleArray;//选中的label
@property (nonatomic,copy)Block block;
- (void)setSelctedBlock:(Block)block;
- (void)updateData;
- (void)onint;


@end
