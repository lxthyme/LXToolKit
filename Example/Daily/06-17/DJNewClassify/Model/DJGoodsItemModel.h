//
//  DJGoodsItemModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/8.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXGoodsInfoListModel.h"

NS_ASSUME_NONNULL_BEGIN

// @class DJRule;
// @class DJGoodsPopinfosList;

@interface DJGoodsItemModel: LXBaseModel {
}
@property (nonatomic, copy)NSString *identifier;
@property (nonatomic, copy)NSString *basePrice;
// @property (nonatomic, copy)id categoryID;
@property (nonatomic, copy)NSString *comSid;
@property (nonatomic, copy)NSString *goodsID;
@property (nonatomic, copy)NSString *goodsImage;
// @property (nonatomic, copy)id goodsType;
// @property (nonatomic, copy)id inStock;
@property (nonatomic, copy)NSString *comGoodCode;
@property (nonatomic, copy)NSString *salePrice;
@property (nonatomic, copy)NSString *plusPrice;
// @property (nonatomic, copy)id discountPrice;
// @property (nonatomic, copy)id endTime;
@property (nonatomic, copy)NSString *priceType;
@property (nonatomic, copy)NSString *limitBuyPersonSum;
@property (nonatomic, copy)NSString *personLimit;
@property (nonatomic, copy)NSString *saleStockStatus;
@property (nonatomic, copy)NSString *limitPopSum;
@property (nonatomic, copy)NSString *productName;
// @property (nonatomic, copy)id pointTitle;
@property (nonatomic, assign)NSInteger saleStockSum;
@property (nonatomic, copy)NSString *marketOn;
// @property (nonatomic, copy)id type;
@property (nonatomic, copy)NSString *brandCNName;
@property (nonatomic, copy)NSArray<DJGoodsPopinfosList *> *popinfosList;
/// RACSequence<DJGoodsPopinfosList *>
@property (nonatomic, copy)RACSequence *f_popinfosList;
@property (nonatomic, copy)NSArray *previewList;
@property (nonatomic, copy)NSArray *xgList;
// @property (nonatomic, copy)id from;
@property (nonatomic, copy)NSString *tdType;
@property (nonatomic, copy)NSString *tdLable;
// @property (nonatomic, copy)id mainTitle;
@property (nonatomic, assign)NSInteger minBuyQuan;
@property (nonatomic, copy)NSString *minBuySpec;
@property (nonatomic, copy)NSDictionary<NSString *, NSNumber *> *pageCat;

@end

NS_ASSUME_NONNULL_END
