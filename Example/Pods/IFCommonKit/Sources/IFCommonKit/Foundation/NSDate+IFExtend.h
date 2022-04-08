//
//  NSDate+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (IFExtend)
// MARK: 日期转字符串
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// MARK: 分解日期
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfMonth;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

/**
 日历
 */
+ (NSCalendar *) if_currentCalendar;
/**
 日期转换
 */
+ (NSDate *)if_convertDateToLocalTime: (NSDate *)forDate;
/**
 当前时间 年月日
 */
+ (NSString *)if_dateNowByYYMMDD;
/**
 当前时间 年月
 */
+ (NSString *)if_dateNowByYYMM;

#pragma mark - 相对日期
+ (NSDate *) if_dateNow;
+ (NSDate *) if_dateTomorrow;
+ (NSDate *) if_dateYesterday;
+ (NSDate *) if_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) if_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) if_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) if_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) if_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) if_dateWithMinutesBeforeNow: (NSInteger) dMinutes;


#pragma mark - 特除时间获取

/**
 指定月份月有多少天
 @param date 日期字符串（yyyyMMdd）:20210827
 */
+ (NSInteger)if_daysOfMonthWithDate:(NSString *)date;

/**
 指定月份的下一个月
 @param date 日期字符串（yyyyMMdd）:20210827
 */
+ (NSString *)if_nextMonthOfDate:(NSString *)date;

/**
 指定月份的下一个月有多少天
 @param date 日期字符串（yyyyMMdd）:20210827
 */
+ (NSInteger)if_daysOfNextMonthWithDate:(NSString *)date;

/**
 指定月份上一个月
 @param date 日期字符串（yyyyMMdd）:20210827
 */
+ (NSString *)if_preMonthOfDate:(NSString *)date;

/**
 指定日期上一个月有多少天
 @param date 日期字符串（yyyyMMdd）:20210827
 */
+ (NSInteger)if_daysOfPreMonthWithDate:(NSString *)date;

/**
 指定两个日期间隔多少天
 */
+ (NSInteger)if_daysBetween:(NSString *)dateStr otherDate:(NSString *)otherDate;


#pragma mark - 日期转字符串
- (NSString *) if_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;

- (NSString *) if_stringWithFormat: (NSString *) format;


#pragma mark - 日期比较
- (BOOL) if_isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) if_isToday;
- (BOOL) if_isTomorrow;
- (BOOL) if_isYesterday;

- (BOOL) if_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) if_isThisWeek;
- (BOOL) if_isNextWeek;
- (BOOL) if_isLastWeek;

- (BOOL) if_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) if_isThisMonth;
- (BOOL) if_isNextMonth;
- (BOOL) if_isLastMonth;

- (BOOL) if_isSameYearAsDate: (NSDate *) aDate;
- (BOOL) if_isThisYear;
- (BOOL) if_isNextYear;
- (BOOL) if_isLastYear;

- (BOOL) if_isEarlierThanDate: (NSDate *) aDate;
- (BOOL) if_isLaterThanDate: (NSDate *) aDate;

- (BOOL) if_isInFuture;
- (BOOL) if_isInPast;

#pragma mark - 日期规则
- (BOOL) if_isTypicallyWorkday;
- (BOOL) if_isTypicallyWeekend;

#pragma mark - 调整日期
- (NSDate *) if_dateByAddingYears: (NSInteger) dYears;
- (NSDate *) if_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) if_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) if_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) if_dateByAddingDays: (NSInteger) dDays;
- (NSDate *) if_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) if_dateByAddingHours: (NSInteger) dHours;
- (NSDate *) if_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) if_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) if_dateBySubtractingMinutes: (NSInteger) dMinutes;

#pragma mark - 极端日期
- (NSDate *) if_dateAtStartOfDay;
- (NSDate *) if_dateAtEndOfDay;

#pragma mark - 日期间隔
- (NSInteger) if_minutesAfterDate: (NSDate *) aDate;
- (NSInteger) if_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) if_hoursAfterDate: (NSDate *) aDate;
- (NSInteger) if_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) if_daysAfterDate: (NSDate *) aDate;
- (NSInteger) if_daysBeforeDate: (NSDate *) aDate;
- (NSInteger) if_distanceInDaysToDate:(NSDate *)anotherDate;

@end

NS_ASSUME_NONNULL_END
