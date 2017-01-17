//
//  NoNetwork.m
//  xmdb
//
//  Created by lili on 16/4/18.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "NoNetwork.h"

@implementation NoNetwork
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.frame = CGRectMake(0, 0, screen_width, screen_height);

    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(85, screen_height / 2 - 200,screen_width - 170, 185)];
    _imageView.backgroundColor=[UIColor clearColor];
    
    _imageView.image=[UIImage imageNamed:@"blankpage_image_loadFail"];
    [self addSubview:_imageView];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, _imageView.bottom , screen_width - 80, 40)];
    _titleLabel.text=@"数据加载失败";
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font=[UIFont systemFontOfSize:AdaptedWidth(16.0)];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    
    _btrefresh = [YJDIYButton buttonWithFrame:CGRectMake(80, _titleLabel.bottom + 10, screen_width - 160, 40) title:@"重新加载" andBlock:^{
        
        if (self.btnBlock) {
            self.btnBlock();
        }
    }];
    [_btrefresh setTitleColor:TextColor forState:UIControlStateNormal];
    _btrefresh.backgroundColor = BackGray;
    _btrefresh.layer.masksToBounds = YES;
    _btrefresh.layer.cornerRadius = 10;
    _btrefresh.layer.borderColor = TextColor.CGColor;
    _btrefresh.layer.borderWidth = 1.0;
    [self addSubview:_btrefresh];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
