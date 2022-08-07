//
//  DJClassifyVM.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyVM.h"

#import <BLAPIManagers/BLProductSearchDoCategoryByLevOneApiManager.h>
#import <BLRawAPIManager/DJNewClassifyListSearchForLHAPIManager.h>
#import <BLRawAPIManager/DJNewHomeShopResourseAPIManager.h>
#import <BLRawAPIManager/DJNewClassifyKdjShopCategoryAPIManager.h>
// #import <BLRawAPIManager/DJGoodsSearchGoodsIdsAPIManager.h>
#import <BLRawAPIManager/DJGoodsSearchGoodsDetailsAPIManager.h>
#import <BLRawAPIManager/DJGoodsSearchBatchCateGoodsAPIManager.h>
#import <BLRawAPIManager/DJNewShopCarAddCartAPIManager.h>

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CTAPIBaseManager+Rac.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import <YYModel/YYModel.h>
#import "DJClassifyMacro.h"


@interface DJClassifyVM()/**<CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>*/ {
}

@property(nonatomic, strong)RACSubject *searchGoodsIdsSubject;
@property(nonatomic, strong)RACSubject *searchGoodsIdsErrorSubject;
@property(nonatomic, strong)RACSubject *tmp_searchGoodsDetailsErrorSubject;

@end

@implementation DJClassifyVM
- (instancetype)init {
    if(self = [super init]) {
        [CTAppContext sharedInstance].apiEnviroment = CTServiceAPIEnviromentDevelop;
        DJStoreManager *gStore = [DJStoreManager sharedInstance];
        /// 仅即时达
        gStore.djModuleType = FIRSTMEDICINE;
        /// 即时达 + 超市精选
        // gStore.djModuleType = COMMONTYPE;
        // gStore.djHomeStyle = DAOJIA;
        /// 超市精选
        // gStore.djHomeStyle = LIANHUA;
        /// 初始化数据
        gStore.shopId = @"007780";
        gStore.shopType = @"2020";
        gStore.bizId = @"2020";
        gStore.comSid = @"2000";
        gStore.merchantId = @"2020007780ENT23234";
        [self prepareUI];
        [self bindVM];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
- (void)bindVM {
    @weakify(self)
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    [self.searchGoodsIdsErrorSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.searchGoodsDetailsErrorSubject sendNext:x];
    }];
    [self.tmp_searchGoodsDetailsErrorSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.searchGoodsDetailsErrorSubject sendNext:x];
    }];
    [self.searchGoodsIdsSubject subscribeNext:^(RACTuple *x) {
        BOOL isAll = [x.first boolValue];
        DJO2OCategoryListModel *t2Category = x.second;
        @strongify(self)
        NSMutableArray<NSString *> *idsList = [NSMutableArray array];
        if(isAll) {
            [idsList addObjectsFromArray:t2Category.f_t2AllCategory.f_idsList.docNos];
        } else {
            [t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if(obj1.cateType != DJO2OCategoryCateTypeAll) {
                    [idsList addObjectsFromArray:obj1.f_idsList.docNos];
                }
            }];
        }
        if(idsList.count <= 0) {
            if(isAll) {
                t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
            } else {
                t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
            }
            [self.searchGoodsIdsErrorSubject sendNext:[NSError errorWithDomain:@"999" code:-999 userInfo:@{}]];
            return;
        }
        NSDictionary *params = @{
            @"ids": idsList,
            @"merchantId": gStore.merchantId,
            @"storeCode": gStore.shopId,
            @"storeType": gStore.shopType,
            @"priceLogic": @0,
            @"picType": @"10006",
        };
        [DJGoodsSearchGoodsDetailsAPIManager loadDataWithParams:params success:^(CTAPIBaseManager *apiManager) {
            @strongify(self)
            // TODO: 「lxthyme」💊 1. success 判断, 2. goodsList 为空判断
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            NSArray *goodsList = arrayFromObject(obj, @"goodsList");
            NSArray<DJO2OGoodItemModel *> *o2oGoodsListModel = [NSArray yy_modelArrayWithClass:[DJO2OGoodItemModel class] json:goodsList];
            NSMutableDictionary *goodsListMap = [NSMutableDictionary dictionary];
            [o2oGoodsListModel enumerateObjectsUsingBlock:^(DJO2OGoodItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.f_itemType = DJClassifyGoodItemTypeO2O;
                if(!isEmptyString(obj.t_id)) {
                    goodsListMap[obj.t_id] = obj;
                }
            }];
            /// 填充三级目录对应的商品数据
            if(isAll) {
                t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
                t2Category.f_t2AllCategory.f_goodsList = o2oGoodsListModel;
            } else {
                t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
                [t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(obj.cateType != DJO2OCategoryCateTypeAll) {
                        NSMutableArray *f_goodsList = [NSMutableArray array];
                        for (NSString *goodsId in obj.f_idsList.docNos) {
                            NSMutableArray *tmp = [[goodsId componentsSeparatedByString:@"_"] mutableCopy];
                            [tmp removeObjectAtIndex:0];
                            NSString *tmp_goodsId = [tmp componentsJoinedByString:@"_"];
                            DJO2OGoodItemModel *item = goodsListMap[tmp_goodsId];
                            if(item) {
                                [f_goodsList addObject:item];
                            }
                        }
                        obj.f_goodsList = [f_goodsList copy];
                    }
                }];
            }
            [self.searchGoodsDetailsSubject sendNext:t2Category];
        } fail:^(CTAPIBaseManager *apiManager) {
            @strongify(self)
            if(isAll) {
                t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
            } else {
                t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
            }
            [self.tmp_searchGoodsDetailsErrorSubject sendNext:apiManager];
        }];
    }];
}
/// 搜索框数据
- (void)loadO2OSearch {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSString *resourceId = @"20220606";

    @weakify(self)
    [DJNewHomeShopResourseAPIManager loadDataWithParams:@{
        @"channelId": @1,
        @"merchantId": gStore.merchantId,
        @"resourceIds": resourceId,
        @"status": @4,
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
            NSArray<DJShopResourceModel *> *shopResourceList = [NSArray yy_modelArrayWithClass:[DJShopResourceModel class] json:obj];
            DJShopResourceModel *shopResourceModel = [shopResourceList.rac_sequence filter:^BOOL(DJShopResourceModel *value) {
                return [value.resourceId isEqualToString:resourceId];
            }].head;
            [self.o2oSearchSubject sendNext:shopResourceModel];
        } else {
            [self.o2oSearchErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.o2oSearchErrorSubject sendNext:apiManager];
    }];
}
- (void)loadO2OBannerWith:(DJO2OCategoryListModel *)t2Category {
    if(t2Category.f_bannerStatus != DJT3DataLoadedStatusNotYet) {
        return;
    }
    t2Category.f_bannerStatus = DJT3DataLoadedStatusLoading;
    if(isEmptyString(t2Category.resourceId)) {
        t2Category.f_bannerStatus = DJT3DataLoadedStatusLoaded;
        t2Category.f_bannerResource = [[DJShopResourceModel alloc]init];
        return;
    }
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    @weakify(self)
    [DJNewHomeShopResourseAPIManager loadDataWithParams:@{
        @"channelId": @1,
        @"merchantId": gStore.merchantId,
        @"resourceIds": t2Category.resourceId,
        @"status": @4,
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
            NSArray<DJShopResourceModel *> *shopResourceList = [NSArray yy_modelArrayWithClass:[DJShopResourceModel class] json:obj];
            DJShopResourceModel *bannerResource = [shopResourceList.rac_sequence filter:^BOOL(DJShopResourceModel *value) {
                return [value.resourceId isEqualToString:t2Category.resourceId];
            }].head;
            t2Category.f_bannerStatus = DJT3DataLoadedStatusLoaded;
            t2Category.f_bannerResource = bannerResource;
            [self.o2oBannerSubject sendNext:t2Category];
        } else {
            t2Category.f_bannerStatus = DJT3DataLoadedStatusNotYet;
            [self.o2oBannerErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        t2Category.f_bannerStatus = DJT3DataLoadedStatusNotYet;
        [self.o2oBannerErrorSubject sendNext:apiManager];
    }];
}

/// 查询分类标题
- (void)loadShopResource {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSString *resourceId = @"2019724";
    self.shopId = gStore.shopId;
    @weakify(self)
    [DJNewHomeShopResourseAPIManager loadDataWithParams:@{
        @"channelId": @1,
        @"merchantId": gStore.merchantId,
        @"resourceIds": resourceId,
        @"status": @4,
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
            NSArray<DJShopResourceModel *> *shopResourceList = [NSArray yy_modelArrayWithClass:[DJShopResourceModel class] json:obj];
            DJShopResourceModel *shopResourceModel = [shopResourceList.rac_sequence filter:^BOOL(DJShopResourceModel *value) {
                return [value.resourceId isEqualToString:resourceId];
            }].head;
            [self.shopResourseSubject sendNext:shopResourceModel];
        } else {
            [self.shopResourseErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.shopResourseErrorSubject sendNext:apiManager];
    }];
}

/// 查询 O2O 目录
- (void)loadShopCategory {
    @weakify(self)
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    [DJNewClassifyKdjShopCategoryAPIManager loadDataWithParams:@{
        @"bizId": gStore.bizId,
        @"merchantId": gStore.merchantId,
        @"shopId": gStore.shopId
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            NSArray *categoryList = arrayFromObject(obj, @"categoryList");
            NSArray<DJO2OCategoryListModel *> *categoryListModel = [NSArray yy_modelArrayWithClass:[DJO2OCategoryListModel class] json:categoryList];
            [self.shopCategorySubject sendNext:categoryListModel];
        } else {
            [self.shopCategoryErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.shopCategoryErrorSubject sendNext:apiManager];
    }];
}

/// O2O 商品信息
- (void)loadSearchGoodsDetailsWith:(DJO2OCategoryListModel *)t2Category
                             isAll:(BOOL)isAll
                        filterType:(DJSubcategoryFilterType)filterType
                         isJiShiDa:(BOOL)isJiShiDa {
    if(isAll && (t2Category.f_allStatus != DJT3DataLoadedStatusNotYet)) {
        return;
    } else if(!isAll && (t2Category.f_notAllStatus != DJT3DataLoadedStatusNotYet)) {
        return;
    }
    __block NSString *promCateId = @"";
    NSMutableArray *cateIdsList = [[[t2Category.rywCategorys.rac_sequence
                              filter:^BOOL(DJO2OCategoryListModel *value) {
        if(value.cateType == DJO2OCategoryCateTypePromotion) {
            promCateId = value.categoryId;
            return NO;
        }
        return value.cateType != DJO2OCategoryCateTypeAll;
    }]
                             map:^id(DJO2OCategoryListModel *value) {
        return value.categoryId;
    }].array mutableCopy];
    if(isAll && (cateIdsList.count <= 0)) {
        [cateIdsList addObject:t2Category.categoryId];
    }
    if(isAll) {
        t2Category.f_allStatus = DJT3DataLoadedStatusLoading;
    } else {
        t2Category.f_notAllStatus = DJT3DataLoadedStatusLoading;
    }
    if(cateIdsList.count <= 0) {
        if(isAll) {
            t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
        } else {
            t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
        }
        [self.searchGoodsIdsErrorSubject sendNext:[NSError errorWithDomain:@"999" code:999 userInfo:@{}]];
        return;
    }
    @weakify(self)
    NSString *tdType = isJiShiDa ? @"0" : @"1";
    NSString *sort = @"";
    switch (filterType) {
        case DJSubcategoryFilterTypeNone:
            sort = @"goodsScore-desc";
            break;
        case DJSubcategoryFilterTypePriceAsc:
            sort = @"salePrice-asc";
            break;
        case DJSubcategoryFilterTypePriceDesc:
            sort = @"salePrice-desc";
            break;
        case DJSubcategoryFilterTypeSale:
            sort = @"goodsScore-asc";
            break;
    }
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSMutableDictionary *params = [@{
        @"merchantId": gStore.merchantId,
        @"storeCode": gStore.shopId,
        @"storeType": gStore.shopType,
        @"comId": gStore.comSid,
        @"tdType": tdType,
        @"cateIds": [cateIdsList componentsJoinedByString:@","],
        @"sort": sort,
        @"cateFlag": isAll ? @"1" : @"0",
    } mutableCopy];
    if(!isEmptyString(promCateId)) {
        params[@"promCateId"] = promCateId;
    }
    [DJGoodsSearchBatchCateGoodsAPIManager loadDataWithParams:params success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        // TODO: 「lxthyme」💊 1. success 判断, 2. idsList 为空判断
        NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
        NSArray<DJGoodsIdsModel *> *idsListModel = [NSArray yy_modelArrayWithClass:[DJGoodsIdsModel class] json:obj];
        NSMutableDictionary<NSString *, DJGoodsIdsModel *> *idsListMap = [NSMutableDictionary dictionary];
        [idsListModel enumerateObjectsUsingBlock:^(DJGoodsIdsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            idsListMap[obj.cateId] = obj;
        }];
        if(isAll) {
            t2Category.f_t2AllCategory.f_idsList = idsListModel.firstObject;
        } else {
            [t2Category.rywCategorys enumerateObjectsUsingBlock:^(DJO2OCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.f_idsList = idsListMap[obj.categoryId];
            }];
        }
        if(idsListModel.count > 0) {
            [self.searchGoodsIdsSubject sendNext:[RACTuple tupleWithObjectsFromArray:@[@(isAll), t2Category]]];
        } else {
            if(isAll) {
                t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
            } else {
                t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
            }
            [self.searchGoodsIdsErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        if(isAll) {
            t2Category.f_allStatus = DJT3DataLoadedStatusLoaded;
        } else {
            t2Category.f_notAllStatus = DJT3DataLoadedStatusLoaded;
        }
        [self.searchGoodsIdsErrorSubject sendNext:apiManager];
    }];
}

/// 查询 B2C 目录
- (void)loadProductSearchDoCategoryByLevOne {
    @weakify(self)
    [BLProductSearchDoCategoryByLevOneApiManager loadDataWithParams:@{
        @"parentId": @"9999300920818"
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        NSString *resultCode = stringFromObject(apiManager.response.content, @"resultCode");
        if([resultCode isEqualToString:@"200"]) {
            NSDictionary *resultInfo = dictionaryFromObject(apiManager.response.content, @"resultInfo");
            NSArray *categorys = arrayFromObject(resultInfo, @"categorys");
            NSArray<DJB2CCategoryModel *> *categoryModelList = [NSArray yy_modelArrayWithClass:[DJB2CCategoryModel class] json:categorys];
            [self.productSearchDoCategoryByLevOneSubject sendNext:categoryModelList];
            // [self.productSearchDoCategoryByLevOneSubject sendCompleted];
        } else {
            [self.productSearchDoCategoryByLevOneErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.productSearchDoCategoryByLevOneErrorSubject sendNext:apiManager];
    }];
}
/// 根据 categorySid 查询 B2C 商品
- (void)loadV2SearchForLHApi:(DJB2CCategoryModel *)t2Category filterType:(DJSubcategoryFilterType)filterType {
    if(t2Category.f_loadStatus != DJT3DataLoadedStatusNotYet) {
        return;
    }
    t2Category.f_loadStatus = DJT3DataLoadedStatusLoading;
    if(isEmptyString(t2Category.categoryId)) {
        t2Category.f_loadStatus = DJT3DataLoadedStatusLoaded;
        [self.v2SearchForLHApiErrorSubject sendNext:[NSError errorWithDomain:@"999" code:999 userInfo:@{}]];
        return;
    }
    NSString *sorCol = @"";
    NSString *sorTye = @"";
    switch (filterType) {
        case DJSubcategoryFilterTypeNone:
            sorCol = @"defSort";
            sorTye = @"";
            break;
        case DJSubcategoryFilterTypePriceAsc:
            sorCol = @"pri";
            sorTye = @"1";
            break;
        case DJSubcategoryFilterTypePriceDesc:
            sorCol = @"pri";
            sorTye = @"0";
            break;
        case DJSubcategoryFilterTypeSale:
            sorCol = @"sal";
            sorTye = @"";
            break;
    }
    NSMutableDictionary *params = [@{
        @"categorySid": t2Category.categoryId,
        @"sorTye": @"0",
        @"pageSize": @"30",
        @"sorCol": sorCol,
        @"pageNo": @"1"
    } mutableCopy];
    if(!isEmptyString(sorTye)) {
        params[@"sorTye"] = sorTye;
    }
    @weakify(self)
    [DJNewClassifyListSearchForLHAPIManager loadDataWithParams:params success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            DJB2CGoodsItemListModel *goodsListModel = [DJB2CGoodsItemListModel yy_modelWithDictionary:obj];
            t2Category.f_goodsList = goodsListModel;
            t2Category.f_loadStatus = DJT3DataLoadedStatusLoaded;
            [self.v2SearchForLHApiSubject sendNext:t2Category];
        } else {
            t2Category.f_loadStatus = DJT3DataLoadedStatusLoaded;
            [self.v2SearchForLHApiErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        t2Category.f_loadStatus = DJT3DataLoadedStatusLoaded;
        [self.v2SearchForLHApiErrorSubject sendNext:apiManager];
    }];
}

// - (void)loadAddCart {
//     DJStoreManager *gStore = [DJStoreManager sharedInstance];
//     NSDictionary *params = @{
//         // @"kdjShopId":
//         // @"storeIndustrySid":
//         // @"orderSourceCode":
//         // @"kdjmerchantID":
//         @"goodsList": @[
//             @{
//                 // @"goodsId":
//             }]
//     };
// }

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️CTAPIManagerParamSource

#pragma mark -
#pragma mark - ✈️CTAPIManagerCallBackDelegate

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareUI {
    self.shopResourseSubject = [RACSubject subject];
    self.shopResourseErrorSubject = [RACSubject subject];
    self.shopCategorySubject = [RACSubject subject];
    self.shopCategoryErrorSubject = [RACSubject subject];
    self.searchGoodsIdsSubject = [RACSubject subject];
    self.searchGoodsIdsErrorSubject = [RACSubject subject];
    self.searchGoodsDetailsSubject = [RACSubject subject];
    self.searchGoodsDetailsErrorSubject = [RACSubject subject];
    self.tmp_searchGoodsDetailsErrorSubject = [RACSubject subject];

    self.productSearchDoCategoryByLevOneSubject = [RACSubject subject];
    self.productSearchDoCategoryByLevOneErrorSubject = [RACSubject subject];
    self.v2SearchForLHApiSubject = [RACSubject subject];
    self.v2SearchForLHApiErrorSubject = [RACSubject subject];
    self.o2oSearchSubject = [RACSubject subject];
    self.o2oSearchErrorSubject = [RACSubject subject];
    self.o2oBannerSubject = [RACSubject subject];
    self.o2oBannerErrorSubject = [RACSubject subject];
}
#pragma mark -
#pragma mark Lazy Property
// - (RACCommand *)productSearchDoCategoryByLevOneCommand {
//     if(!_productSearchDoCategoryByLevOneCommand){
//         @weakify(self)
//         RACCommand *cmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//             @strongify(self)
//             // self.djNewShopCarSubmitCartAPIManager.finalParamsToCall = @{};
//             return [[[self.productSearchDoCategoryByLevOneApiManager rac_requestSignal] doNext:^(CTAPIBaseManager *_Nullable apiManager) {
//                 // self.f_result = apiManager.response.content;
//             }] materialize];
//         }];
//         _productSearchDoCategoryByLevOneCommand = cmd;
//     }
//     return _productSearchDoCategoryByLevOneCommand;
// }
// - (RACCommand *)v2SearchForLHApiCommand {
//     if(!_v2SearchForLHApiCommand){
//         @weakify(self)
//         RACCommand *cmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//             @strongify(self)
//             // self.djNewShopCarSubmitCartAPIManager.finalParamsToCall = @{};
//             return [[[self.v2SearchForLHApiManager rac_requestSignal] doNext:^(CTAPIBaseManager *_Nullable apiManager) {
//                 // self.f_result = apiManager.response.content;
//             }] materialize];
//         }];
//         _v2SearchForLHApiCommand = cmd;
//     }
//     return _v2SearchForLHApiCommand;
// }
- (DJShopCartVM *)shopCartVM {
    if(!_shopCartVM){
        DJShopCartVM *vm = [[DJShopCartVM alloc]init];
        _shopCartVM = vm;
    }
    return _shopCartVM;
}
@end
