//
//  CalendarConfigure.h
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateHelper.h"
@interface CalendarConfigure : NSObject
@property (nonatomic, strong)   NSDateComponents *dateComponents;
@property (nonatomic, readonly) NSInteger        firstDay;
@property (nonatomic, readonly) NSInteger        daysOfmonth;
@property (nonatomic, readonly) NSInteger        weeksOfmonth;
@property (nonatomic, assign)   BOOL             isCurrentMonth;
@end
