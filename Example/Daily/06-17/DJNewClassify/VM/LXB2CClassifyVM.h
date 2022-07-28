//
//  LXB2CClassifyVM.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LXLHCategoryModel.h"
#import "LXB2CGoodsItemListModel.h"
#import "LXShopResourceModel.h"
#import "DJO2OCategoryListModel.h"

#import "DJGoodsIdsModel.h"
#import "LXO2OGoodItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXB2CClassifyVM: NSObject {
}
@property(nonatomic, strong)RACCommand *productSearchDoCategoryByLevOneCommand;
@property(nonatomic, strong)RACCommand *v2SearchForLHApiCommand;

@property(nonatomic, strong)RACSubject *productSearchDoCategoryByLevOneSubject;
@property(nonatomic, strong)RACSubject *productSearchDoCategoryByLevOneErrorSubject;
@property(nonatomic, strong)RACSubject *shopCategorySubject;
@property(nonatomic, strong)RACSubject *shopCategoryErrorSubject;
@property(nonatomic, strong)RACSubject *searchGoodsDetailsSubject;
@property(nonatomic, strong)RACSubject *searchGoodsDetailsErrorSubject;

@property(nonatomic, strong)RACSubject *v2SearchForLHApiSubject;
@property(nonatomic, strong)RACSubject *v2SearchForLHApiErrorSubject;
@property(nonatomic, strong)RACSubject *shopResourseSubject;
@property(nonatomic, strong)RACSubject *shopResourseErrorSubject;

/// 查询分类标题
- (void)loadShopResource;
/// 查询 O2O 目录
- (void)loadShopCategory;
/// 查询 O2O 商品信息
- (void)loadSearchGoodsDetailsWithCategoryId:(NSString *)categoryId;
/// 查询 B2C 目录
- (void)loadProductSearchDoCategoryByLevOne;
/// 查询 B2C 商品信息
- (void)loadV2SearchForLHApi:(NSString *)categorySid;
@end

NS_ASSUME_NONNULL_END
