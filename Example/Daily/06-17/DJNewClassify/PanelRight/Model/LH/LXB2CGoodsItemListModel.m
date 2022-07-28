//
//  LXGoodsInfoListModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXB2CGoodsItemListModel.h"

@interface LXB2CGoodsItemListModel() {
}

@end

@implementation LXB2CGoodsItemListModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"goodsInfoList": [LXB2CGoodItemModel class]
    };
}


#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

@end

@implementation LXB2CGoodItemModel

#pragma mark -
#pragma mark - 👀Public Actions
- (NSString *)xl_goodsName {
    return self.salesName;
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
