
//
//  YJCityCollectionCell.m
//  全球向导
//
//  Created by SYJ on 2017/1/5.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJCityCollectionCell.h"

@implementation YJCityCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        self.backgroundColor = BackGray;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
