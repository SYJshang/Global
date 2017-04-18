
//
//  YJChatCell.m
//  全球向导
//
//  Created by SYJ on 2017/3/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJChatCell.h"

@implementation YJChatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessibilityIdentifier = @"table_cell";
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head"]];
        [self.contentView addSubview:self.icon];
        self.icon.sd_layout.centerYEqualToView(self.contentView).heightIs(65).widthIs(65).leftSpaceToView(self.contentView,10);
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = self.icon.width / 2;
        self.icon.layer.borderColor = BackGroundColor.CGColor;
        self.icon.layer.borderWidth = 1.0;
        
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.textColor = [UIColor blackColor];
        self.name.font = [UIFont systemFontOfSize:AdaptedWidth(17)];
        self.name.sd_layout.leftSpaceToView(self.icon, 10).topSpaceToView(self.contentView, 20).widthIs(100).heightIs(20);
        
        self.message = [[UILabel alloc]init];
        [self.contentView addSubview:self.message];
        self.message.textColor = [UIColor lightGrayColor];
        self.message.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        self.message.sd_layout.leftSpaceToView(self.icon, 10).bottomSpaceToView(self.contentView, 15).widthIs(150).heightIs(20);
        
        self.time = [[UILabel alloc]init];
        [self.contentView addSubview:self.time];
        self.time.textColor = [UIColor lightGrayColor];
        self.time.textAlignment = NSTextAlignmentRight;
        self.time.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
        self.time.sd_layout.rightSpaceToView(self.contentView, 10).centerYEqualToView(self.name).widthIs(100).heightRatioToView(self.name, 1);
        
        
        self.badge = [[UILabel alloc]init];
        [self.contentView addSubview:self.badge];
        self.badge.textColor = [UIColor whiteColor];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.backgroundColor = [UIColor redColor];
        self.badge.font = [UIFont systemFontOfSize:AdaptedWidth(11)];
        self.badge.sd_layout.rightSpaceToView(self.contentView, 10).centerYEqualToView(self.message).widthIs(20).heightIs(20);
        self.badge.layer.masksToBounds = YES;
        self.badge.layer.cornerRadius = 8;
        self.badge.text = @"1";
        
        
        
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = BackGroundColor;
        line.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 1).heightIs(1);

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}

+ (NSString *)cellIdentifierWithModel:(id)model
{
    return @"EaseConversationCell";
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 80;
}




- (void)setModel:(id<IConversationModel>)model{
    
    _model = model;
    
    
    
    EMMessage *message = _model.conversation.lastReceivedMessage;
    NSDictionary *dic = message.ext;
    XXLog(@"%@",dic);
    
    
    if ([model.title length] > 0 && dic) {
        self.name.text = dic[@"MyNickName"];
    }else{
        self.name.text = model.conversation.conversationId;
    }
    
    if (dic){
            [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"MyPicUrl"]] placeholderImage:[UIImage imageNamed:@"head"]];
        } else {
            if (model.avatarImage) {
                self.icon.image = [UIImage imageNamed:@"head"];
            }
        }
    
    if (model.conversation.unreadMessagesCount == 0) {
        self.badge.hidden = YES;
    }
    else{
        self.badge.hidden = NO;
        self.badge.text = [NSString stringWithFormat:@"%d",model.conversation.unreadMessagesCount];
    }

    
}
@end
