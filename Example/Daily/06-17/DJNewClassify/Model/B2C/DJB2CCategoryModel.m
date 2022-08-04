//
//  DJB2CCategoryModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJB2CCategoryModel.h"

@interface DJB2CCategoryModel() {
}

@end

@implementation DJB2CCategoryModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"categorys": [DJB2CCategoryModel class]
    };
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
