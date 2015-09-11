//
//  YXCollectionViewCell.h
//  YXFit
//
//  Created by deathewind on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel* dateLabel;
// change the background of the current day to  red
@property (nonatomic,assign) BOOL weekend;
@end


@interface CollectionHeaderView : UICollectionReusableView
@property (nonatomic,strong) UILabel *titleLabel;
@end




@protocol footerViewDelegate <NSObject>
- (void)loadMoreTime:(UIButton *)button;
@end
@interface CollectionFooterView : UICollectionReusableView
@property (nonatomic,strong) UIButton *button;
@property (nonatomic, assign) id<footerViewDelegate>delegate;
@end