#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDictionary *monthDictionary = [NSDictionary dictionaryWithObjects: [currentCalendar monthSymbols] forKeys:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12]];
    
    return monthDictionary[@(monthNumber)];
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromString = [dateFormatter dateFromString:date];
    
    return (long)[[calendar components: NSCalendarUnitDay fromDate:dateFromString] day];
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];
    [dateFormatter setDateFormat:@"E"];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate now];
    
    
    NSDateComponents *currentWeekDay = [currentCalendar components:NSCalendarUnitWeekday | NSCalendarUnitHour fromDate:currentDate];
    
    NSDateComponents *subtractComponent = [NSDateComponents new];

    [subtractComponent setDay:-([currentWeekDay weekday] - 2)];
    [subtractComponent setHour: -[currentWeekDay hour]];
    [subtractComponent setMinute:0];
    [subtractComponent setSecond:0];
    
    NSDate *beginningOfWeek = [currentCalendar dateByAddingComponents:subtractComponent toDate:currentDate options:0];
    
    [subtractComponent setDay: 7 - [currentWeekDay weekday] + 1];
    
    NSDate *endOfWeek = [currentCalendar dateByAddingComponents:subtractComponent toDate:currentDate options:0];
    
    BOOL isEarlier = [date compare: beginningOfWeek] == NSOrderedAscending;
    BOOL isLater = [date compare:endOfWeek] == NSOrderedDescending;
    
    if (isEarlier || isLater) {
        return NO;
    }
    
    return YES;
}

@end
