//
//  DJClassifyListBannerCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/7.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyListBannerCell.h"

#import <Masonry/Masonry.h>

@interface DJClassifyListBannerCell() {
}

@end

@implementation DJClassifyListBannerCell
@synthesize imageView = _imageView;

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
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    YYAnimatedImageView *imgView = [[YYAnimatedImageView alloc]init];
    _imageView = imgView;
    [self.contentView addSubview:imgView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
@end
