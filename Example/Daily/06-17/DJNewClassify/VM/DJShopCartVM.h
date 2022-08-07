//
//  DJShopCartVM.h
//  DJGlobalStoreManager
//
//  Created by lxthyme on 2022/8/5.
//
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <DJGlobalStoreManager/DJQueryCartModel.h>
#import "DJQueryCartCouponsListModel.h"
#import "DJO2OGoodItemModel.h"
#import "DJB2CGoodsItemListModel.h"
#import "DJAddCartResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJShopCartVM: NSObject {
}
@property(nonatomic, strong)RACBehaviorSubject *queryCartSubject;
@property(nonatomic, strong)RACSubject *queryCartErrorSubject;

@property(nonatomic, strong)RACSubject *o2oAddCartSubject;
@property(nonatomic, strong)RACSubject *o2oAddCartErrorSubject;

@property(nonatomic, strong)RACSubject *b2cAddCartSubject;
@property(nonatomic, strong)RACSubject *b2cAddCartErrorSubject;

/// 查询购物车
- (void)loadQueryCart;

/// 加车
- (void)addCartWithB2C:(DJB2CGoodItemModel *)goodItem;
- (void)addCartWithO2O:(DJO2OGoodItemModel *)goodItem;

@end

NS_ASSUME_NONNULL_END
