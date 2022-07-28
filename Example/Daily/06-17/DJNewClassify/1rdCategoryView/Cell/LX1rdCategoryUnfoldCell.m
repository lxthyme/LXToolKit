//
//  LX1rdCategoryUnfoldCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/4.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LX1rdCategoryUnfoldCell.h"

@interface LX1rdCategoryUnfoldCell() {
}

@end

@implementation LX1rdCategoryUnfoldCell

#pragma mark -
#pragma mark - 👀Public Actions
- (void)prepareCategoryConfig {
    [self configCategoryWithLogoWidth:kWPercentage(43.f)
                          borderWidth:kWPercentage(1.5f) wrapperSpacing:kWPercentage(3.5f)
                          labelHeight:kWPercentage(17.f)];
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
