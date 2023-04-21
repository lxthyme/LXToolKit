//
//  DJVerticalTableView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/31.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJVerticalTableView.h"

#import <Masonry/Masonry.h>

@interface DJVerticalTableView() {
}

@end

@implementation DJVerticalTableView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self basePrepareUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // });
    !self.layoutSubviewsCallback ?: self.layoutSubviewsCallback();
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)basePrepareUI {
    self.backgroundColor = [UIColor whiteColor];

    // [self addSubview:self.<#table#>];

    [self baseMasonry];
}

#pragma mark Masonry
- (void)baseMasonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
