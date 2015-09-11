//
//  YXCollectionViewCell.m
//  YXFit
//
//  Created by deathewind on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _dateLabel.textColor = RGB(60, 60, 60);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_dateLabel];
    }
    return self;
}

- (void)setWeekend:(BOOL)weekend{
    _weekend = weekend;
    if (weekend) {
        _dateLabel.textColor = [UIColor orangeColor];
    }else{
        _dateLabel.textColor = RGB(60, 60, 60);
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _dateLabel.layer.cornerRadius = _dateLabel.frame.size.height / 2;
        _dateLabel.clipsToBounds = YES;
        _dateLabel.backgroundColor = RGB(199, 21, 133);
        _dateLabel.textColor = [UIColor whiteColor];
    } else {
        _dateLabel.backgroundColor = [UIColor clearColor];
        if (_weekend) {
            _dateLabel.textColor = [UIColor orangeColor];
        }else{
            _dateLabel.textColor = RGB(60, 60, 60);
        }

    }
    [super setSelected:selected];
}

@end

@implementation CollectionHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = RGB(245, 245, 245);
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];

    }
    return self;
}
@end
@implementation CollectionFooterView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [_button setTitle:@"加载更多" forState:UIControlStateNormal];
        [_button setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_button addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}
- (void)loadMore:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(loadMoreTime:)]) {
        [self.delegate loadMoreTime:button];
    }
}
@end