//
//  LXShopResourceModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXShopResourceModel.h"

@interface LXShopResourceModel() {
}

@end

@implementation LXShopResourceModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"onlineDeployList": [DJOnlineDeployList class]
    };
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@implementation DJOnlineDeployList

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end
