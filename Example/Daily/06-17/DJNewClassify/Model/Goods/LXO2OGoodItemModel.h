//
//  LXO2OGoodItemModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "LXGoodBaseItemModel.h"
@class LXO2OGoodItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface LXO2OGoodItemModel: LXGoodBaseItemModel {
}
@property (nonatomic, copy)NSString *t_id;
@property (nonatomic, copy)NSString *categoryId;
@property (nonatomic, copy)NSString *comSid;
@property (nonatomic, copy)NSString *goodsId;
@property (nonatomic, copy)NSString *goodsImage;
@property (nonatomic, copy)NSString *inStock;
@property (nonatomic, copy)NSString *comGoodCode;
@property (nonatomic, copy)NSString *plusPrice;
@property (nonatomic, copy)NSString *discountPrice;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *personLimit;
@property (nonatomic, copy)NSString *limitPopSum;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *pointTitle;
@property (nonatomic, copy)NSString *brandCnName;
@property (nonatomic, copy)NSString *from;
@property (nonatomic, copy)NSString *tdType;
@property (nonatomic, copy)NSString *tdLable;
@property (nonatomic, copy)NSString *mainTitle;
@property (nonatomic, copy)NSString *minBuySpec;
@property (nonatomic, copy)NSDictionary *pageCat;

@end

NS_ASSUME_NONNULL_END
