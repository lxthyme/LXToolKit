//
//  LXSubCategoryPinView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSubCategoryPinView.h"

#import <Masonry/Masonry.h>

@interface LXSubCategoryPinView() {
}

@end

@implementation LXSubCategoryPinView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    // [self addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
