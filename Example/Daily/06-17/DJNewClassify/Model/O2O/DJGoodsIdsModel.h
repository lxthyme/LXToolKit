//
//  DJGoodsIdsModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXO2OGoodItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJGoodsIdsModel: LXBaseModel {
}
@property (nonatomic, copy)NSString *cateId;
@property (nonatomic, copy)NSArray<NSString *> *docNos;

@property (nonatomic, copy)NSString *f_2rdCategoryId;
@property (nonatomic, copy)NSArray<LXO2OGoodItemModel *> *f_goodsList;

@end

NS_ASSUME_NONNULL_END
