//
//  LXB2CGoodsItemListModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXGoodBaseItemModel.h"
#import "LXO2OGoodItemModel.h"
#import "DJGoodsIdsModel.h"

@class LXB2CGoodItemModel;

typedef NS_ENUM(NSInteger, DJGoodsRuleType) {
    DJGoodsRuleTypeUnknown,
    /// 新人价
    DJGoodsRuleType12,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXB2CGoodsItemListModel: LXBaseModel {
}
@property (nonatomic, assign)NSInteger totalCount;
@property (nonatomic, assign)NSInteger totalPage;
@property (nonatomic, assign)NSInteger pageNum;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, copy)NSArray<LXGoodBaseItemModel *> *goodsInfoList;
@property (nonatomic, copy)NSString *f_categoryId;

/// 「only O2O」
// @property (nonatomic, copy)NSArray<LXO2OGoodItemModel *> *f_o2oGoodsInfo;
@property (nonatomic, strong)DJGoodsIdsModel *f_o2oIdsModel;

@end

@interface LXB2CGoodItemModel: LXGoodBaseItemModel {
}

@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, copy)NSString *salesName;
@property (nonatomic, copy)NSString *brandSid;
@property (nonatomic, strong)NSDictionary *pic;
@property (nonatomic, assign)NSInteger goodsScore;
@property (nonatomic, assign)NSInteger secondaryScore;
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, assign)NSInteger pageSortField;
@property (nonatomic, assign)NSInteger rowNum;

@end

NS_ASSUME_NONNULL_END

