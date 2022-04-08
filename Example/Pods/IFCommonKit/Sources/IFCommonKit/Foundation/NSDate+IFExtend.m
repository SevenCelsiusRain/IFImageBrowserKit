//
//  NSDate+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSDate+IFExtend.h"

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (IFExtend)

#pragma mark - private method

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate*)getPriousorLaterDateFromDate:(NSDate*)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}


#pragma mark - public method

/**
 *  获获取当前客户端的逻辑日历
 *
 *  @return 当前客户端的逻辑日历
 */
+ (NSCalendar *) if_currentCalendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}

/**
 *  将日期转换为当前时区的日期
 *
 *  @param forDate 要转换的日期
 *
 *  @return 转换过的日期
 */
+ (NSDate *)if_convertDateToLocalTime: (NSDate *)forDate {

    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    NSInteger timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    return newDate;
}

+ (NSString *)if_dateNowByYYMMDD {
    NSDate *date = [NSDate if_dateNow];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    return [formatter stringFromDate:date];
}

+ (NSString *)if_dateNowByYYMM {
    NSDate *date = [NSDate if_dateNow];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMM";
    return [formatter stringFromDate:date];
}


#pragma mark - 相对日期

/**
 *  现在的日期
 *
 *  @return 现在的日期
 */
+ (NSDate *) if_dateNow {
    return [self if_convertDateToLocalTime:[NSDate date]];
}

/**
 *  明天的日期
 *
 *  @return 明天的日期
 */
+ (NSDate *) if_dateTomorrow {
    return [self if_convertDateToLocalTime:[NSDate if_dateWithDaysFromNow:1]];
}

/**
 *  昨天的日期
 *
 *  @return 昨天日期
 */
+ (NSDate *) if_dateYesterday {
    return [self if_convertDateToLocalTime:[NSDate if_dateWithDaysBeforeNow:1]];
}


/**
 *  从现在起向后推几天的日期
 *
 *  @param days 向后推的天数
 *
 *  @return 后推得到的日期
 */
+ (NSDate *) if_dateWithDaysFromNow: (NSInteger) days {
    return [self if_convertDateToLocalTime:[[NSDate date] if_dateByAddingDays:days]];
}

/**
 *  从现在起向前推几天的日期
 *
 *  @param days 向前推的天数
 *
 *  @return 前推得到的日期
 */
+ (NSDate *) if_dateWithDaysBeforeNow: (NSInteger) days {
    return [self if_convertDateToLocalTime:[[NSDate date] if_dateByAddingDays:days]];

    return [[NSDate date] if_dateBySubtractingDays:days];
}

/**
 *  从现在起向后推几小时的日期
 *
 *  @param dHours 向后推的小时数
 *
 *  @return 后推得到的日期
 */
+ (NSDate *) if_dateWithHoursFromNow: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_convertDateToLocalTime:newDate];
}

/**
 *  从现在起向前推几小时的日期
 *
 *  @param dHours 向前推的小时数
 *
 *  @return 前推得到的日期
 */
+ (NSDate *) if_dateWithHoursBeforeNow: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_convertDateToLocalTime:newDate];
}

/**
 *  从现在起向后推几分钟的日期
 *
 *  @param dMinutes 向后推的分钟数
 *
 *  @return 后推得到的日期
 */
+ (NSDate *) if_dateWithMinutesFromNow: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_convertDateToLocalTime:newDate];
}

/**
 *  从现在起向前推几分钟的日期
 *
 *  @param dMinutes 向前推的分钟数
 *
 *  @return 前推得到的日期
 */
+ (NSDate *) if_dateWithMinutesBeforeNow: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_convertDateToLocalTime:newDate];
}


#pragma mark - 特除时间获取

+ (NSInteger)if_daysOfMonthWithDate:(NSString *)date {
    NSDate *tmpDate = [NSDate dateWithString:date format:@"yyyyMMdd"];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tmpDate];
    NSInteger dayCountOfThisMonth = daysInLastMonth.length;
    
    return dayCountOfThisMonth;
}

+ (NSString *)if_nextMonthOfDate:(NSString *)date {
    NSDate*tmpDate = [NSDate dateWithString:date format:@"yyyyMMdd"];
    NSDate *preMonth = [self getPriousorLaterDateFromDate:tmpDate withMonth:1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *agoString = [dateFormatter stringFromDate:preMonth];
    
    return agoString;
}

+ (NSInteger)if_daysOfNextMonthWithDate:(NSString *)date {
    NSString *dateStr = [NSDate if_nextMonthOfDate:date];
    return [NSDate if_daysOfMonthWithDate:dateStr];
}

+ (NSString *)if_preMonthOfDate:(NSString *)date {
    NSDate*tmpDate = [NSDate dateWithString:date format:@"yyyyMMdd"];
    NSDate *preMonth = [self getPriousorLaterDateFromDate:tmpDate withMonth:-1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *agoString = [dateFormatter stringFromDate:preMonth];
    
    return agoString;
}

+ (NSInteger)if_daysOfPreMonthWithDate:(NSString *)date {
    NSString *dateStr = [NSDate if_preMonthOfDate:date];
    return [NSDate if_daysOfMonthWithDate:dateStr];
}

+ (NSInteger)if_daysBetween:(NSString *)dateStr otherDate:(NSString *)otherDate {
    NSDate *oneDate = [NSDate dateWithString:dateStr format:@"yyyyMMdd"];
    NSDate *twoDate = [NSDate dateWithString:otherDate format:@"yyyyMMdd"];
    NSTimeInterval inter = [oneDate timeIntervalSinceDate:twoDate];
    NSInteger days = inter/(3600*24);
    
    return days;
}



#pragma mark -日期转换为String

/**
 *  通过系统自带的时间风格 来得到字符串
 *
 *  @param dateStyle 日期格式 年月日
 *  @param timeStyle 时间格式 时分秒
 *
 *  @return 得到最终的字符串
 */
- (NSString *) if_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    return [formatter stringFromDate:self];
}

// 使用NSDateFormatter转换时间字符串时，默认的时区是系统时区，如我们使用一般都是北京时间(＋8)

/**
 *  通过format格式将当前日期转换为String格式
 *
 *  @param format 格式样式
 *
 *  @return 转换后得到的String
 */
- (NSString *) if_stringWithFormat: (NSString *) format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}



#pragma mark - 日期比较
/**
 *  抛弃时间外 日期是否相等 精确到天的范围内
 *
 *  @param aDate 比较的date
 *
 *  @return YES 相等 NO 不相等
 */
- (BOOL) if_isEqualToDateIgnoringTime: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

/**
 *  日期是不是今天
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isToday {
    return [self if_isEqualToDateIgnoringTime:[NSDate date]];
}

/**
 *  日期是不是明天
 *
 *  @return YES  是 NO 不是
 */
- (BOOL) if_isTomorrow {
    return [self if_isEqualToDateIgnoringTime:[NSDate if_dateTomorrow]];
}

/**
 *  是不是昨天
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isYesterday {
    return [self if_isEqualToDateIgnoringTime:[NSDate if_dateYesterday]];
}

/**
 *  判断和指定日期是否是同一个星期内的
 *
 *  @param aDate 相比较的日期
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isSameWeekAsDate: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:componentFlags fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (abs((int)[self timeIntervalSinceDate:aDate]) < D_WEEK);
}

/**
 *  判断是不是本周
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isThisWeek {
    return [self if_isSameWeekAsDate:[NSDate date]];
}

/**
 *  判断是不是下周
 *
 *  @return YES 是 NO  不是
 */
- (BOOL) if_isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_isSameWeekAsDate:newDate];
}

/**
 *  判断是不是上周
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self if_isSameWeekAsDate:newDate];
}

/**
 *  判断是不是同一个月
 *
 *  @param aDate 比较的日期
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isSameMonthAsDate: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

/**
 *  判断是不是本月
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isThisMonth {
    return [self if_isSameMonthAsDate:[NSDate date]];
}

/**
 *  判断是不是上个月
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isLastMonth {
    return [self if_isSameMonthAsDate:[[NSDate date] if_dateBySubtractingMonths:1]];
}

/**
 *  判断是不是下个月
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isNextMonth {
    return [self if_isSameMonthAsDate:[[NSDate date] if_dateByAddingMonths:1]];
}

/**
 *  判断是不是同一年
 *
 *  @param aDate 比较的日期
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isSameYearAsDate: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

/**
 *  判断是不是本年
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isThisYear {
    return [self if_isSameYearAsDate:[NSDate date]];
}

/**
 *  判断是不是下一年
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isNextYear {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return (components1.year == (components2.year + 1));
}

/**
 *  判断是不是上一年
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isLastYear {
    NSDateComponents *components1 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate if_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return (components1.year == (components2.year - 1));
}

/**
 *  判断是不是比指定日期早
 *
 *  @param aDate 指定的日期
 *
 *  @return YES 早 NO 不早
 */
- (BOOL) if_isEarlierThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

/**
 *  判断是不是比指定日期晚
 *
 *  @param aDate 指定的日期
 *
 *  @return YES 晚 NO 不晚
 */
- (BOOL) if_isLaterThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

/**
 *  判断一个日期是不是在将来
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isInFuture {
    return ([self if_isLaterThanDate:[NSDate date]]);
}

/**
 *  判断一个日期是不是在过去
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isInPast {
    return ([self if_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - 星期内工作日
/**
 *  是不是周六日
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isTypicallyWeekend {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

/**
 *  是不是工作日
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) if_isTypicallyWorkday {
    return ![self if_isTypicallyWeekend];
}

#pragma mark - 调整日期
/**
 *  指定日期后推几年得到的日期
 *
 *  @param dYears 后推的年数
 *
 *  @return 后推后得到的日期
 */
- (NSDate *) if_dateByAddingYears: (NSInteger) dYears {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/**
 *  指定日期前推几年得到的日期
 *
 *  @param dYears 前推的年数
 *
 *  @return 前推得到的日期
 */
- (NSDate *) if_dateBySubtractingYears: (NSInteger) dYears {
    return [self if_dateByAddingYears:-dYears];
}

/**
 *  指定日期后推几个月得到的日期
 *
 *  @param dMonths 后推的月数
 *
 *  @return 后推后得到的日期
 */
- (NSDate *) if_dateByAddingMonths: (NSInteger) dMonths {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/**
 *  指定日期前推几个月得到的日期
 *
 *  @param dMonths 前推的月数
 *
 *  @return 前推后得到的日期
 */
- (NSDate *) if_dateBySubtractingMonths: (NSInteger) dMonths {
    return [self if_dateByAddingMonths:-dMonths];
}

/**
 *  指定日期后推几天得到的日期
 *
 *  @param dDays 后推的天数
 *
 *  @return 后推得到的日期
 */
- (NSDate *) if_dateByAddingDays: (NSInteger) dDays {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/**
 *  指定日期前推几天的到的日期
 *
 *  @param dDays 前推的天数
 *
 *  @return 前推得到的日期
 */
- (NSDate *) if_dateBySubtractingDays: (NSInteger) dDays {
    return [self if_dateByAddingDays: (dDays * -1)];
}

/**
 *  指定日期后推几小时得到的日期
 *
 *  @param dHours 后推的几个小时
 *
 *  @return 后推后的日期
 */
- (NSDate *) if_dateByAddingHours: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/**
 *  指定日期前推几小时得到的日期
 *
 *  @param dHours 前推的小时数
 *
 *  @return 前推后得到的日期
 */
- (NSDate *) if_dateBySubtractingHours: (NSInteger) dHours {
    return [self if_dateByAddingHours: (dHours * -1)];
}

/**
 *  指定日期后推几分钟得到的日期
 *
 *  @param dMinutes 后推的分钟数
 *
 *  @return 后推得到的日期
 */
- (NSDate *) if_dateByAddingMinutes: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/**
 *  指定日期前推几分钟得到的日期
 *
 *  @param dMinutes 前推的分钟数
 *
 *  @return 前推得到的日期
 */
- (NSDate *) if_dateBySubtractingMinutes: (NSInteger) dMinutes {
    return [self if_dateByAddingMinutes: (dMinutes * -1)];
}

/**
 *  指定日期和给的日期之间相差的时间
 *
 *  @param aDate 比较的日期
 *
 *  @return 相差的时间
 */
- (NSDateComponents *) if_componentsWithOffsetFromDate: (NSDate *) aDate {
    NSDateComponents *dTime = [[NSDate if_currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - 极端例子
/**
 *  得到指定日期这一天的开始日期
 *
 *  @return 得到的日期
 */
- (NSDate *) if_dateAtStartOfDay {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate if_currentCalendar] dateFromComponents:components];
}

/**
 *  得到指定日期这一天的结束日期
 *
 *  @return 得到的日期
 */
- (NSDate *) if_dateAtEndOfDay {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate if_currentCalendar] dateFromComponents:components];
}

#pragma mark - 检索间隔
/**
 *  得到当前日期在给定日期之后的分钟数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的分钟数
 */
- (NSInteger) if_minutesAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

/**
 *  得到当前日期在给定日期之前的分钟数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的分钟数
 */
- (NSInteger) if_minutesBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

/**
 *  得到当前日期在给定日期之后的小时数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的小时数
 */
- (NSInteger) if_hoursAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

/**
 *  得到当前日期在给定日期之后的小时数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的小时数
 */
- (NSInteger) if_hoursBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

/**
 *  得到当前日期在给定日期之后的天数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的天数
 */
- (NSInteger) if_daysAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

/**
 *  得到当前日期在给定日期之后的天数
 *
 *  @param aDate 给定的日期
 *
 *  @return 得到的天数
 */
- (NSInteger) if_daysBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

/**
 *  当前的日期和给定的日期之间相差的天数
 *
 *  @param anotherDate 给定的日期
 *
 *  @return 相差的天数
 */
- (NSInteger) if_distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - getter (日期分解)
/**
 *  距离当前时间最近的小时 比如9：55 就是10：00 9：25就是9：00
 *
 *  @return 最近的小时
 */
- (NSInteger) nearestHour {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate if_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

/**
 *  当前日期的小时
 *
 *  @return 当前日期的小时
 */
- (NSInteger) hour {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

/**
 *  当前日期的分钟
 *
 *  @return 当前日期的分钟
 */
- (NSInteger) minute {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

/**
 *  当前日期的秒
 *
 *  @return 当前日期的秒
 */
- (NSInteger) seconds {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

/**
 *  当前日期的几号
 *
 *  @return 当前日期的几号
 */
- (NSInteger) day {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

/**
 *  当前日期的几月
 *
 *  @return 当前日期的几月
 */
- (NSInteger) month {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

/**
 *  当前月的第几周
 *
 *  @return 当前月的第几周
 */
- (NSInteger) weekOfMonth {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

/**
 *  当前年的第几周
 *
 *  @return 当前年的第几周
 */
- (NSInteger) weekOfYear {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

/**
 *  当前日期所在周的第几天
 *
 *  @return 第几天
 */
- (NSInteger) weekday {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

/**
 *  当前日期所在年的第几季度
 *
 *  @return 获得的季度
 *  // e.g. 2nd Tuesday of the month is 2
 */
- (NSInteger) nthWeekday  {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

/**
 *  当前日期的年
 *
 *  @return 当前日期的年
 */
- (NSInteger) year {
    NSDateComponents *components = [[NSDate if_currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}


#pragma mark - getter (日期转字符串)

/**
 *  5/5/15, 10:48 AM
 *
 *  @return 相应格式的日期+时间
 */
- (NSString *) shortString {
    return [self if_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

/**
 *  10:48 AM
 *
 *  @return 相应格式的时间
 */
- (NSString *) shortTimeString {
    return [self if_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

/**
 *  5/5/15
 *
 *  @return 响应格式的日期
 */
- (NSString *) shortDateString {
    return [self if_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

/**
 *  May 5, 2015, 10:35:23 AM
 *
 *  @return 相应格式的日期+时间
 */
- (NSString *) mediumString {
    return [self if_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

/**
 *  10:35:23 AM
 *
 *  @return 相应格式的时间
 */
- (NSString *) mediumTimeString {
    return [self if_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

/**
 *  May 5, 2015
 *
 *  @return 相应格式的日期
 */
- (NSString *) mediumDateString {
    return [self if_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

/**
 *  May 5, 2015 at 10:35:23 AM GMT+8
 *
 *  @return 相应格式的日期+时间
 */
- (NSString *) longString {
    return [self if_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

/**
 *  May 5, 2015
 *
 *  @return 相应格式的时间
 */
- (NSString *) longTimeString {
    return [self if_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

/**
 *  10:35:23 AM GMT+8
 *
 *  @return 相应格式的日期
 */
- (NSString *) longDateString {
    return [self if_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}


@end
