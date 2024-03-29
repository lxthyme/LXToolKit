//
//  DJO2OGoodItemModel.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "DJGoodBaseItemModel.h"
@class DJO2OGoodItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface DJO2OGoodItemModel: DJGoodBaseItemModel {
}
@property (nonatomic, copy)NSString *t_id;
// @property (nonatomic, copy)NSString *basePrice;
@property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSString *comSid;
@property (nonatomic, copy)NSString *goodsId;
@property (nonatomic, copy)NSString *goodsImage;
// @property (nonatomic, copy)NSString *goodsType;
@property (nonatomic, copy)NSString *inStock;
@property (nonatomic, copy)NSString *comGoodCode;
// @property (nonatomic, copy)NSString *salePrice;
@property (nonatomic, copy)NSString *plusPrice;
@property (nonatomic, copy)NSString *discountPrice;
@property (nonatomic, copy)NSString *endTime;
// @property (nonatomic, copy)NSString *priceType;
// @property (nonatomic, copy)NSString *limitBuyPersonSum;
@property (nonatomic, copy)NSString *personLimit;
// @property (nonatomic, copy)NSString *saleStockStatus;
@property (nonatomic, copy)NSString *limitPopSum;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *pointTitle;
// @property (nonatomic, copy)NSString *saleStockSum;
// @property (nonatomic, copy)NSString *marketOn;
// @property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *brandCnName;
// @property (nonatomic, copy)NSArray<DJGoodItemPopinfosList *> *popinfosList;
// @property (nonatomic, copy)NSArray *previewList;
// @property (nonatomic, copy)NSArray *xgList;
@property (nonatomic, copy)NSString *from;
@property (nonatomic, copy)NSString *tdType;
@property (nonatomic, copy)NSString *tdLable;
@property (nonatomic, copy)NSString *mainTitle;
// @property (nonatomic, assign)NSInteger minBuyQuan;
@property (nonatomic, copy)NSString *minBuySpec;
@property (nonatomic, copy)NSDictionary *pageCat;


@end

NS_ASSUME_NONNULL_END
