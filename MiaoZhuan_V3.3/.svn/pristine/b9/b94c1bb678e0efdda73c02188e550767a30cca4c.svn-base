//
//  CRDateCounter.m
//  miaozhuan
//
//  Created by abyss on 14/11/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRDateCounter.h"
#import <objc/runtime.h>

static CRDateCounter *cr_DateCountManager = nil;
@implementation CRDateCounter

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!cr_DateCountManager)
        {
            cr_DateCountManager = [[CRDateCounter alloc] init];
        }
    });
    return cr_DateCountManager;
}

- (NSArray *)dateCount:(NSArray *)array forKey:(NSString *)key
{
    
    if (!array || array.count == 0) return nil;
    NSMutableArray *pArray = [[NSMutableArray new] autorelease];
    NSUInteger currentDay = -1;
    NSUInteger arrayCount = -1;
    for (int i = 0; i < array.count; i ++)
    {
        NSDate *myDate = [NSDate dateFromString:[UICommon format19Time:[array[i] objectForKey:key]] withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",[myDate string]);
        NSString *date = nil;
        NSUInteger daysAgo = [myDate daysAgo];
        NSLog(@"%@ is %d daysago",[myDate string],(int)daysAgo);
        if (daysAgo == 0)
        {
            date = @"今天";
        }
        else if (daysAgo == 1)
        {
            date = @"昨天";
        }
        else
        {
            date = [myDate stringWithFormat:@"yyyy-MM-dd"];
        }
        
        if (currentDay == daysAgo)
        {
            [pArray[arrayCount] addObject:@{@"Data":array[i],@"Date":date}];
        }
        else
        {
            arrayCount ++;
            [pArray addObject:[NSMutableArray array]];
            [pArray[arrayCount] addObject:@{@"Data":array[i],@"Date":date}];
            currentDay = daysAgo;
        }
    }
    
    return pArray;
}

- (NSString *)crmz_formatDateFromStr:(NSString *)str
{
    NSString *endStr = [UICommon format19Time:str];
    NSDate *date = [NSDate dateFromString:endStr];
    if (endStr.length < 9) return @" ";
    NSString *pStr = [endStr substringFromIndex:11];
    pStr = [pStr substringToIndex:5];
    NSLog(@"%@",pStr);
    
    if ([date daysAgo] == 0)
    {
        if ([date timeIntervalSinceNow] > -120)
        {
            endStr = @"刚刚";
            return endStr;
        }
        endStr = [NSString stringWithFormat:@"今天 %@",pStr];
    }
    else if ([date daysAgo] == 1)
    {
        endStr = [NSString stringWithFormat:@"昨天 %@",pStr];
    }
    else
    {
        endStr = [endStr substringToIndex:16];
    }
    return endStr;
}

- (NSString *)datecut:(int)length with:(NSString *)str
{
    NSString *ret = [str copy];
    return [ret substringToIndex:length];
}

@end

















@implementation NSDate (cr_DateCounter_Additon)

- (NSUInteger)daysAgo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
//    21:00 ---- +4
    NSDateComponents *today = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    today.day += 1;
    NSDate* pDate = [calendar dateFromComponents:today];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:pDate
                                                options:0];
    
//    NSDate* today = [NSDate datef]
    return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    [mdf release];
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%d days ago", (int)daysAgo];
    }
    return text;
}

- (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}

+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    [inputFormatter release];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    NSString *displayString = nil;
    
    // comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
    if (midnight_result == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        [componentsToSubtract release];
        NSComparisonResult lastweek_result = [date compare:lastweek];
        if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                [displayFormatter setDateFormat:@"EEEE h:mm a"];
            } else {
                [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
            }
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d"];
                }
            } else {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d, yyyy"];
                }
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    
    [displayFormatter release];
    
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    return [[self class] stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    [outputFormatter release];
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    [outputFormatter release];
    return outputString;
}

- (NSDate *)beginningOfWeek {
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    [componentsToSubtract release];
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    [componentsToAdd release];
    
    return endOfWeek;
}

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}

@end