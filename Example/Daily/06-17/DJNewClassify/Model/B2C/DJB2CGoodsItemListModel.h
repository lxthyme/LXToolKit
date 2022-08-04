//
//  DJB2CGoodsItemListModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "DJGoodBaseItemModel.h"
#import "DJO2OGoodItemModel.h"
#import "DJGoodsIdsModel.h"
#import "DJO2OCategoryListModel.h"

@class DJB2CGoodItemModel;

typedef NS_ENUM(NSInteger, DJGoodsRuleType) {
    DJGoodsRuleTypeUnknown,
    /// 新人价
    DJGoodsRuleType12,
};

NS_ASSUME_NONNULL_BEGIN

@interface DJB2CGoodsItemListModel: LXBaseModel {
}
@property (nonatomic, assign)NSInteger totalCount;
@property (nonatomic, assign)NSInteger totalPage;
@property (nonatomic, assign)NSInteger pageNum;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, copy)NSArray<DJB2CGoodItemModel *> *goodsInfoList;

@end

@interface DJB2CGoodItemModel: DJGoodBaseItemModel {
}
// @property (nonatomic, copy)NSString *type;
// @property (nonatomic, copy)NSString *goodsType;

@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, copy)NSString *salesName;
@property (nonatomic, copy)NSString *brandSid;
// @property (nonatomic, copy)NSString *basePrice;
// @property (nonatomic, copy)NSString *salePrice;
// @property (nonatomic, copy)NSString *saleStockSum;
// @property (nonatomic, copy)NSString *saleStockStatus;
// @property (nonatomic, copy)NSString *limitBuyPersonSum;
@property (nonatomic, strong)NSDictionary *pic;
// @property (nonatomic, copy)NSString *marketOn;
// @property (nonatomic, copy)NSString *priceType;
// @property (nonatomic, copy)NSArray<DJGoodItemPopinfosList *> *popinfosList;
// @property (nonatomic, copy)NSArray *previewList;
// @property (nonatomic, copy)NSArray *xgList;
@property (nonatomic, assign)NSInteger goodsScore;
@property (nonatomic, assign)NSInteger secondaryScore;
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, assign)NSInteger pageSortField;
@property (nonatomic, assign)NSInteger rowNum;
// @property (nonatomic, assign)NSInteger minBuyQuan;
@end

NS_ASSUME_NONNULL_END

