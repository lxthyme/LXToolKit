//
//  LXMyCollectionView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXMyCollectionView.h"

#import <Masonry/Masonry.h>

@interface LXMyCollectionView() {
}

@end

@implementation LXMyCollectionView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)layoutSubviews {
    [super layoutSubviews];

    self.layoutSubviewsCallback();
}
@end
