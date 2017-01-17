//
//  CHTCalendarView.h
//  CHTCalendar
//
//  Created by risenb_mac on 16/8/9.
//  Copyright © 2016年 risenb_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameHelper)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end

@interface NSDate (CalendarHelper)

- (NSInteger)numberOfDaysInCurrentMonth;
- (NSInteger)weeklyOfCurrentDay;

@end

@interface CHTCalendarView : UIView

/**
 *  标记的日期数组
 */
@property (nonatomic, strong) NSArray *markedDays;
/**
 *  标记日期填充颜色
 */
@property (nonatomic, strong) UIColor *markedDayFilledColor;
/**
 *  标记日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *markedDayColor;

/**
 *  选中的日期数组
 */
@property (nonatomic, strong) NSMutableArray *selectedDays;
/**
 *  选中日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *selectedDayColor;
/**
 *  选中日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *selectedDayFilledColor;

/**
 *  title：“日 一 二 三 四 五 六”
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 *  阳历
 */
@property (nonatomic, strong) UIFont *dayFont;
/**
 *  农历
 */
@property (nonatomic, strong) UIFont *chineseDayFont;
/**
 *  date： “2016年08月”
 */
@property (nonatomic, strong) UIFont *dateFont;

/**
 *  行距
 */
@property (nonatomic, assign) CGFloat lineSpacing;
/**
 *  列距
 */
@property (nonatomic, assign) CGFloat itemSpacing;
/**
 *  日期边长
 */
@property (nonatomic, assign) CGFloat dayWidth;
/**
 *  日期圆角
 */
@property (nonatomic, assign) CGFloat dayCornerRadius;
/**
 *  日期距title的距离
 */
@property (nonatomic, assign) CGFloat daysToTitleSpacing;
/**
 *  日期边框宽度
 */
@property (nonatomic, assign) CGFloat dayBordarWidth;
/**
 *  上下年月 按钮高度
 */
@property (nonatomic, assign) CGFloat btnHeight;

/**
 *  周末日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *weekendDayColor;
/**
 *  工作日日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *workingDayColor;
/**
 *  当前日期文字、边框颜色
 */
@property (nonatomic, strong) UIColor *currentDayColor;
/**
 *  当前日期日期填充颜色
 */
@property (nonatomic, strong) UIColor *currentDayFilledColor;
/**
 *  2016年08月 颜色
 */
@property (nonatomic, strong) UIColor *dateColor;
/**
 *  上下年 按钮颜色
 */
@property (nonatomic, strong) UIColor *yearBtnColor;
/**
 *  上下月 按钮颜色
 */
@property (nonatomic, strong) UIColor *monthBtnColor;
/**
 *  普通日期填充颜色
 */
@property (nonatomic, strong) UIColor *dayFilledColor;

/**
 *  显示边框
 */
@property (nonatomic, assign) BOOL showBordar;
/**
 *  显示农历
 */
@property (nonatomic, assign) BOOL showChineseDay;
/**
 *  是否可以多选
 */
@property (nonatomic, assign) BOOL selectMany;
/**
 *  边框内是否填充
 */
@property (nonatomic, assign) BOOL dayFilled;
/**
 *  当前日 边框内是否填充
 */
@property (nonatomic, assign) BOOL currentDayFilled;
/**
 *  选中日 边框内是否填充
 */
@property (nonatomic, assign) BOOL selectedDayFilled;
/**
 *  标记日 边框内是否填充
 */
@property (nonatomic, assign) BOOL markedDayFilled;

/**
 *  刷新界面方法
 */
- (void)reloadInterface;

@end
