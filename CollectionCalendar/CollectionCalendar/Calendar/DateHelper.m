//
//  DateHelper.m
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+ (int)getDaysInMonth:(int)month year:(int)year
{
    int daysInFeb = 28;
    if (year%4 == 0) {
        daysInFeb = 29;
    }
    int daysInMonth [12] = {31,daysInFeb,31,30,31,30,31,31,30,31,30,31};
    return daysInMonth[month-1];
}

+ (NSArray*)getMonths{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return calendar.monthSymbols;
}


+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month{
    if (month == 0) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond |
        NSCalendarUnitCalendar;
        comps = [calendar components:unitFlags fromDate:[NSDate date]];
        return comps;
        
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* new = [[NSDateComponents alloc]init];
    new.month = month;
    NSDate *date =  [calendar dateByAddingComponents:new toDate:[NSDate date] options:NSCalendarMatchNextTime];
    //  NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitCalendar;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}


+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitWeekOfMonth | NSCalendarUnitEra) fromDate:[NSDate date]];
    return components;
}


+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents
{
    NSDateComponents *month = [monthComponents copy];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitCalendar;
    month.day = 1;
    comps = [calendar components:unitFlags fromDate:[calendar dateFromComponents:month]];
    return comps;
}
@end
