//
//  DJGoodsIdsModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJGoodsIdsModel: LXBaseModel {
}
@property (nonatomic, assign)NSInteger pages;
@property (nonatomic, assign)NSInteger pageNo;
@property (nonatomic, assign)NSInteger reassureShopCursor;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, copy)NSArray<NSString *> *ids;
@property (nonatomic, assign)NSInteger mainShopCursor;

@end

NS_ASSUME_NONNULL_END
