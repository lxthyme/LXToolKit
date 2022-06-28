//
//  LXClassifySectionHeaderView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifySectionHeaderView.h"

#import <Masonry/Masonry.h>

@interface LXClassifySectionHeaderView() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation LXClassifySectionHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXSectionModel *)model {
    self.labTitle.text = model.title;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

    [self addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0.f);
        make.left.equalTo(@16.f);
        make.right.lessThanOrEqualTo(@(-16.f));
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"";
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
