//
//  CalendarViewController.h
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CollectionViewCell.h"
#import "CalendarConfigure.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define CellHeight 46
#define HeaderViewHeight 30
//#define CellWidth 45
#define CellLine 1
@interface CalendarViewController : UIViewController

@property(nonatomic, strong) NSIndexPath *indexChoose;

@property(nonatomic, copy)   void(^dateChoose)(NSString *dateString, NSIndexPath *datePath);
@end
