//
//  DJAddCartResultModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/7.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJAddCartResultModel: LXBaseModel {
}
@property(nonatomic, copy)NSString *shoppingCartType;
@property(nonatomic, assign)CGFloat freightLessPrice;
@property(nonatomic, assign)CGFloat totalPrice;
@property(nonatomic, assign)CGFloat showTotalPrice;
@property(nonatomic, copy)NSString *shoppingCartId;
@property(nonatomic, assign)NSInteger allGoodsNumber;
@property(nonatomic, copy)NSArray *failGoodsList;
@property(nonatomic, assign)NSInteger totalGoodsAmount;
@property(nonatomic, assign)NSInteger currentGoodsNumber;
@property(nonatomic, assign)CGFloat freightLessWeight;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *goodsLineNbr;
@property(nonatomic, assign)NSInteger totalGoodsNumber;
@property(nonatomic, assign)NSInteger newGoodsNumber;
@property(nonatomic, assign)NSInteger status;
@property(nonatomic, assign)NSInteger timestamp;

@end

NS_ASSUME_NONNULL_END
