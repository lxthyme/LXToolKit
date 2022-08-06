//
//  DJClassifyVM.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DJB2CCategoryModel.h"
#import "DJB2CGoodsItemListModel.h"
#import "DJShopResourceModel.h"
#import "DJO2OCategoryListModel.h"

#import "DJGoodsIdsModel.h"
#import "DJO2OGoodItemModel.h"
#import "DJClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyVM: NSObject {
}
@property(nonatomic, copy)NSString *shopId;
@property(nonatomic, strong)RACCommand *productSearchDoCategoryByLevOneCommand;
@property(nonatomic, strong)RACCommand *v2SearchForLHApiCommand;

/// 分类页类型
@property(nonatomic, strong)RACSubject *shopResourseSubject;
@property(nonatomic, strong)RACSubject *shopResourseErrorSubject;
/// b2c 目录
@property(nonatomic, strong)RACSubject *productSearchDoCategoryByLevOneSubject;
@property(nonatomic, strong)RACSubject *productSearchDoCategoryByLevOneErrorSubject;
/// b2c 商品信息
@property(nonatomic, strong)RACSubject *v2SearchForLHApiSubject;
@property(nonatomic, strong)RACSubject *v2SearchForLHApiErrorSubject;
/// o2o 目录
@property(nonatomic, strong)RACSubject *shopCategorySubject;
@property(nonatomic, strong)RACSubject *shopCategoryErrorSubject;
/// o2o 商品信息
@property(nonatomic, strong)RACSubject *searchGoodsDetailsSubject;
@property(nonatomic, strong)RACSubject *searchGoodsDetailsErrorSubject;
/// o2o 搜索资源位
@property(nonatomic, strong)RACSubject *o2oSearchSubject;
@property(nonatomic, strong)RACSubject *o2oSearchErrorSubject;
/// (O2O)二级目录 banner 资源位
@property(nonatomic, strong)RACSubject *o2oBannerSubject;
@property(nonatomic, strong)RACSubject *o2oBannerErrorSubject;

/// 查询分类标题
- (void)loadShopResource;
/// 查询 O2O 目录
- (void)loadShopCategory;
/// 查询 O2O 商品信息
- (void)loadSearchGoodsDetailsWith:(DJO2OCategoryListModel *)o2oCategoryModel
                             isAll:(BOOL)isAll;
/// (O2O)搜索框数据
- (void)loadO2OSearch;
/// (O2O)二级目录 banner 资源位
- (void)loadO2OBannerWithResourceId:(NSString *)resourceId categoryId:(NSString *)categoryId;

/// 查询 B2C 目录
- (void)loadProductSearchDoCategoryByLevOne;
/// 查询 B2C 商品信息
- (void)loadV2SearchForLHApi:(NSString *)categorySid;
@end

NS_ASSUME_NONNULL_END
