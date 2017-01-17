//
//  YJFirstCell.h
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@protocol LunboDelegate <NSObject>


- (void)Lunbo:(NSInteger)index;

@end

@interface YJFirstCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *imagesURLStrings;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, weak) id <LunboDelegate>delegate;

@end
