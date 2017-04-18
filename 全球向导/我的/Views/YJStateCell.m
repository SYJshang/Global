//
//  YJStateCell.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJStateCell.h"

#define PADDING_OF_LEFT_STEP_LINE 50
#define PADDING_OF_LEFT_RIGHT 15
#define WIDTH_OF_PROCESS_LABLE (300 *[UIScreen mainScreen].bounds.size.width / 375)

@implementation YJStateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initView{
    
    //竖线
    self.verticalLabel1 = [[UILabel alloc] init];
    self.verticalLabel1.backgroundColor = BackGroundColor;
    [self.contentView addSubview:self.verticalLabel1];
    
    //竖线
    self.verticalLabel2 = [[UILabel alloc] init];
    self.verticalLabel2.backgroundColor = BackGroundColor;
    [self.contentView addSubview:self.verticalLabel2];
    
    //圆圈⭕️
    self.circleView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleView.backgroundColor = [UIColor whiteColor];
    self.circleView.layer.borderColor = BackGroundColor.CGColor;
    self.circleView.layer.cornerRadius = 8;
    self.circleView.layer.borderWidth = 2;
    [self.contentView addSubview:self.circleView];
    
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(17)];
    [self.contentView addSubview:self.titleLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    self.timeLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.timeLabel];
    
    //描述
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
    self.timeLabel.textColor = [UIColor grayColor];
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    
    self.verticalLabel1.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .heightIs(10);
    
    self.verticalLabel2.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .bottomEqualToView(self.contentView);
    
    self.circleView.sd_layout
    .centerXEqualToView(self.verticalLabel1)
    .centerYEqualToView(self.contentView)
    .heightIs(16)
    .widthIs(16);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.verticalLabel1,PADDING_OF_LEFT_RIGHT)
    .topSpaceToView(self.contentView,3)
    .heightIs(15)
    .rightEqualToView(self.contentView);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,9)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .heightIs(11)
    .rightEqualToView(self.contentView);
    
    self.detailLabel.sd_layout
    .topSpaceToView(self.timeLabel,0)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .widthIs(WIDTH_OF_PROCESS_LABLE)
    .heightIs(30);
    
}

-(void)setModel:(YJStateModle *)model{
    _model = model;
    self.titleLabel.text = model.titleStr;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.timeStr];
    self.detailLabel.text = model.detailSrtr;
    if (model.detailSrtr.length > 1) {
        //描述lab隐藏
        NSDictionary *fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE,0);
        CGSize detailStrSize = [model.detailSrtr boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
        self.detailLabel.sd_layout
        .topSpaceToView(self.timeLabel,5)
        .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
        .widthIs(WIDTH_OF_PROCESS_LABLE)
        .heightIs(detailStrSize.height + 12);
    }
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
