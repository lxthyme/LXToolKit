//
//  LXO2OGoodItemModel.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXO2OGoodItemModel.h"

@interface LXO2OGoodItemModel() {
}

@end

@implementation LXO2OGoodItemModel
#pragma mark -
#pragma mark - 🛠Life Cycle
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"t_id": @"id"

    };
}

#pragma mark -
#pragma mark - 👀Public Actions
- (NSString *)xl_goodsName {
    return self.productName;
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
