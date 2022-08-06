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

    // [self.<#contentView#> addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
