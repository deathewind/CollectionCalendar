//
//  DateHelper.h
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject
// return the count of day in a certain month ,a certain year
+ (int)getDaysInMonth:(int)month year:(int)year;

//获取某个月的第一天
+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents;

// get the dateComponents from the date, you can get some info from dateComponents
+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date;

// according to the current date , +/- month , return a new dateComponents with new month
+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month;

// return the array of month name in a year
+ (NSArray*)getMonths;
@end
