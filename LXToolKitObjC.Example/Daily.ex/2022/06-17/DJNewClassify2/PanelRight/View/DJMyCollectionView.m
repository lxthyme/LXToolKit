//
//  DJMyCollectionView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJMyCollectionView.h"

#import <Masonry/Masonry.h>

@interface DJMyCollectionView() {
}

@end

@implementation DJMyCollectionView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)layoutSubviews {
    [super layoutSubviews];

    self.layoutSubviewsCallback();
}
@end
