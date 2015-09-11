//
//  CalendarConfigure.m
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CalendarConfigure.h"

@implementation CalendarConfigure
- (void)setDateComponents:(NSDateComponents *)dateComponents{
    _dateComponents = dateComponents;
    NSDateComponents *firstDateMonthComponents = [DateHelper firstDateComponentsWithMonthComponents:dateComponents];
    
    NSInteger firstDay = firstDateMonthComponents.weekday - 1;
    
    NSInteger daysOfmonth = [DateHelper getDaysInMonth:dateComponents.month year:dateComponents.year];
    NSInteger weeksOfmonth = (daysOfmonth + firstDay)/7;
    if((daysOfmonth + firstDay) %7 != 0){
        weeksOfmonth ++ ;
    }
    _firstDay = firstDay;
    _daysOfmonth = daysOfmonth;
    _weeksOfmonth = weeksOfmonth;
    if(dateComponents.month == [DateHelper getDateComponentsWithDate:[NSDate date]].month){
        _isCurrentMonth = YES;
    }else{
        _isCurrentMonth  = NO;
    }
}

@end
