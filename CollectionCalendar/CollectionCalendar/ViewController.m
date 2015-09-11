//
//  ViewController.m
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UILabel *label; //日期时间标签
@property(nonatomic, strong) NSIndexPath *indexPa; //记录日期选择的位置
@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
            [self setNeedsStatusBarAppearanceUpdate];
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 60, 44)];
        _label.font = [UIFont systemFontOfSize:17];
        _label.textAlignment = NSTextAlignmentRight;
        _label.textColor = RGB(199, 21, 133);
        [cell addSubview:_label];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textColor = RGB(60, 60, 60);
    }
     cell.textLabel.text = @"选择日期";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CalendarViewController *calendar = [[CalendarViewController alloc] init];
    if (_indexPa != nil) {
        calendar.index = _indexPa;
    }
    calendar.dateChoose = ^(NSString *dateString, NSIndexPath *path){
        _label.text = dateString;
        _indexPa = path;
    };
    
    [self.navigationController pushViewController:calendar animated:YES];
}
@end
