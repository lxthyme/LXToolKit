//
//  LXLHCategoryModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXLHCategoryModel.h"

@interface LXLHCategoryModel() {
}

@end

@implementation LXLHCategoryModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"categorys": [LXLHCategoryModel class]
    };
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
