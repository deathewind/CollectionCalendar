//
//  CalendarViewController.m
//  CollectionCalendar
//
//  Created by deathewind on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, footerViewDelegate>
{
    NSInteger integer;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *dataView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CalendarViewController
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
    [self creaCalendar];
}
- (void)creaCalendar{
    self.dataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 38)];
    self.dataView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.dataView];
    NSArray* array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < array.count; i ++) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7.0*i, 0, self.view.frame.size.width/7.0, self.dataView.frame.size.height)];
        label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        label.font = [UIFont systemFontOfSize:17];
        if (i==0 ||i==array.count -1) {
            label.textColor = [UIColor orangeColor];
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        [self.dataView addSubview:label];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.dataView.frame.size.height - CellLine, self.dataView.frame.size.width, CellLine)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.dataView addSubview:line];
    
    //加载8个月以内的日期
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:8];
    
    integer = 0;
    [self getDataBydata:2];
    

}
- (void)getDataBydata:(NSInteger)count{
    for (int i = 0; i < count; i ++) {
        NSDateComponents *com = [DateHelper getOtherMonthComponentsWithCurrentDate:integer];
        CalendarConfigure *calendar = [[CalendarConfigure alloc] init];
        calendar.dateComponents = com;
        [self.dataArray addObject:calendar];
        integer += 1;
    }
    [self.collectionView reloadData];
}
#pragma mark collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CalendarConfigure *Configure = [self.dataArray objectAtIndex:section];
    return Configure.weeksOfmonth * 7 ;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        CalendarConfigure *Configure = [self.dataArray objectAtIndex:indexPath.section];
        headerView.titleLabel.text = [NSString stringWithFormat:@"%li %@",(long)Configure.dateComponents.year,[DateHelper getMonths][Configure.dateComponents.month-1]];
        return headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        CollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionFooterView" forIndexPath:indexPath];
        footerView.delegate = self;
        return footerView;
        
    }
    return nil;
}

#pragma mark footerViewDelegate
- (void)loadMoreTime:(UIButton *)button{
    if (self.dataArray.count == 8) {
        [button setTitle:@"超出时间范围" forState:UIControlStateNormal];
        button.enabled = NO;
    }
    [self getDataBydata:2];
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.weekend = NO;
    CalendarConfigure *Configure = [self.dataArray objectAtIndex:indexPath.section];
    if((indexPath.row < Configure.firstDay) || (indexPath.row > Configure.firstDay + Configure.daysOfmonth -1)) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        NSInteger currentDay = indexPath.row - Configure.firstDay + 1;
        cell.dateLabel.text = [NSString stringWithFormat:@"%ld", (long)currentDay];
        cell.selected = [collectionView.indexPathsForSelectedItems containsObject:indexPath];
        if (indexPath.row%7 == 0 || indexPath.row%7 == 6){
            cell.weekend = YES;
        }
        if (Configure.isCurrentMonth) {
            if (indexPath.row < Configure.dateComponents.day + Configure.firstDay - 1) {
                cell.userInteractionEnabled = NO;
                cell.dateLabel.textColor = RGB(136, 136, 136);
            }else{
                cell.userInteractionEnabled = YES;
                if (currentDay == Configure.dateComponents.day) {
                    cell.dateLabel.text = @"今天";
                }
            }
            
        }else{
            cell.userInteractionEnabled = YES;
        }
        //上次选择的
        if (self.indexChoose && indexPath.row == self.indexChoose.row && indexPath.section == self.indexChoose.section) {
            cell.selected = YES;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.indexChoose) {
        CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:self.indexChoose];
        cell.selected = NO;
        self.indexChoose = nil;
    }
    CalendarConfigure *Configure = [self.dataArray objectAtIndex:indexPath.section];
    NSString *chooseData = [NSString stringWithFormat:@"%ld-%02ld-%02d",(long)Configure.dateComponents.year,(long)Configure.dateComponents.month,indexPath.row - Configure.firstDay + 1];
    // NSLog(@"chooseData = %@ --- %d --- %d --- %@", chooseData , indexPath.section, indexPath.row, indexPath);
    _dateChoose(chooseData, indexPath);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/7.0, CellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, HeaderViewHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1) {
        return CGSizeMake(ScreenWidth, HeaderViewHeight);
    }
    return CGSizeMake(0, 0);
}



- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.dataView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.dataView.frame.size.height - 64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = NO;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
        [_collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionFooterView"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end
