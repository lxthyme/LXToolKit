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
        [self prepareUI];
        [self bindVM];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
- (void)bindVM {
    @weakify(self)
    [self.searchGoodsIdsErrorSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.searchGoodsDetailsErrorSubject sendNext:x];
    }];
    [self.tmp_searchGoodsDetailsErrorSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.searchGoodsDetailsErrorSubject sendNext:x];
    }];
    [self.searchGoodsIdsSubject subscribeNext:^(RACTuple *x) {
        NSString *o2oCategoryId = x.first;
        BOOL isAll = [x.second boolValue];
        NSArray<DJClassifyGoodsInfoModel *> *goodsInfoList = x.third;
        @strongify(self)
        NSMutableArray<NSString *> *idsList = [NSMutableArray array];
        [goodsInfoList enumerateObjectsUsingBlock:^(DJClassifyGoodsInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [idsList addObjectsFromArray:obj.f_o2oGoodsInfo.docNos];
        }];

        if(idsList.count <= 0) {
            [self.searchGoodsIdsErrorSubject sendNext:[NSError errorWithDomain:@"999" code:-999 userInfo:@{}]];
            return;
        }
        NSDictionary *params = @{
            @"ids": idsList,
            @"shuffle": @"0",
            @"storeType": @"2020",
            @"storeCode": @"007780",
            @"merchantId": @"2020007780ENT23234",
            @"version": @"7.44.0",
            @"skuType": @0,
            @"fromApp": @"IOS"
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
            [goodsInfoList enumerateObjectsUsingBlock:^(DJClassifyGoodsInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableArray *goodsList = [NSMutableArray array];
                if(obj.f_o2oGoodsInfo.docNos.count > 0) {
                    for (NSString *goodsId in obj.f_o2oGoodsInfo.docNos) {
                        NSMutableArray *arr = [[goodsId componentsSeparatedByString:@"_"] mutableCopy];
                        [arr removeObjectAtIndex:0];
                        NSString *f_goodsId = [arr componentsJoinedByString:@"_"];
                        DJO2OGoodItemModel *goodsItem = goodsListMap[f_goodsId];
                        if(goodsItem) {
                            goodsItem.f_itemType = DJClassifyGoodItemTypeO2O;
                            [goodsList addObject:goodsItem];
                        } else {
                            DJGoodBaseItemModel *emptyItem = [[DJGoodBaseItemModel alloc]init];
                            emptyItem.f_itemType = DJClassifyGoodItemTypeEmpty;
                            [goodsList addObject:emptyItem];
                        }
                    }
                } else {
                    DJGoodBaseItemModel *emptyItem = [[DJGoodBaseItemModel alloc]init];
                    emptyItem.f_itemType = DJClassifyGoodItemTypeEmpty;
                    [goodsList addObject:emptyItem];
                }
                obj.f_o2oGoodsInfo.f_goodsList = [goodsList copy];
            }];
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[o2oCategoryId, @(isAll), goodsInfoList]];
            [self.searchGoodsDetailsSubject sendNext:tuple];
        } fail:^(CTAPIBaseManager *apiManager) {
            @strongify(self)
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
- (void)loadO2OBannerWithResourceId:(NSString *)resourceId categoryId:(NSString *)categoryId {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];

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
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[categoryId, shopResourceModel]];
            [self.o2oBannerSubject sendNext:tuple];
        } else {
            [self.o2oBannerErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.o2oBannerErrorSubject sendNext:apiManager];
    }];
}

/// 查询分类标题
- (void)loadShopResource {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSString *resourceId = @"2019724";

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
    [DJNewClassifyKdjShopCategoryAPIManager loadDataWithParams:@{
        @"bizId": @"2020",
        @"fromApp": @"IOS",
        @"merchantId": @"2020007780ENT23234",
        @"shopId": @"007780",
        @"version": @"7.58.0",
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
- (void) loadSearchGoodsDetailsWith:(DJO2OCategoryListModel *)o2oCategoryModel
                             isAll:(BOOL)isAll {
    NSString *endCateIds = [[[o2oCategoryModel.rywCategorys.rac_sequence
                              filter:^BOOL(DJO2OCategoryListModel *value) {
        return ![value.categoryId isEqualToString:@"-1"];
    }]
                             map:^id(DJO2OCategoryListModel *value) {
        return value.categoryId;
    }].array componentsJoinedByString:@","];
    if(isAll && isEmptyString(endCateIds)) {
        endCateIds = o2oCategoryModel.categoryId;
    }
    if(isEmptyString(o2oCategoryModel.categoryId) || isEmptyString(endCateIds)) {
        [self.searchGoodsIdsErrorSubject sendNext:[NSError errorWithDomain:@"999" code:999 userInfo:@{}]];
        return;
    }
    @weakify(self)
    NSDictionary *params = @{
        @"cateIds": endCateIds,
        @"merchantId": @"2020007780ENT23234",
        @"storeCode": @"007780",
        @"storeType": @"2020",
        @"tdType": @"1",
        @"cateFlag": isAll ? @"1" : @"0",
    };
    [DJGoodsSearchBatchCateGoodsAPIManager loadDataWithParams:params success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        // TODO: 「lxthyme」💊 1. success 判断, 2. idsList 为空判断
        NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
        NSArray<DJGoodsIdsModel *> *idsListModel = [NSArray yy_modelArrayWithClass:[DJGoodsIdsModel class] json:obj];
        if(idsListModel.count > 0) {
            NSArray<DJClassifyGoodsInfoModel *> *f_goodsInfoList = [idsListModel.rac_sequence map:^id(DJGoodsIdsModel *value) {
                DJClassifyGoodsInfoModel *goodsInfoModel = [[DJClassifyGoodsInfoModel alloc]init];
                goodsInfoModel.f_itemType = DJClassifyGoodItemTypeO2O;
                goodsInfoModel.f_2rdCategoryId = o2oCategoryModel.categoryId;
                goodsInfoModel.f_o2oGoodsInfo = value;
                return goodsInfoModel;
            }].array;
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[o2oCategoryModel.categoryId, @(isAll), f_goodsInfoList]];
            [self.searchGoodsIdsSubject sendNext:tuple];
        } else {
            [self.searchGoodsIdsErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
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
- (void)loadV2SearchForLHApi:(NSString *)categorySid {
    if(isEmptyString(categorySid)) {
        [self.v2SearchForLHApiErrorSubject sendNext:[NSError errorWithDomain:@"999" code:999 userInfo:@{}]];
        return;
    }
    @weakify(self)
    [DJNewClassifyListSearchForLHAPIManager loadDataWithParams:@{
        @"categorySid": categorySid,
        @"sorTye": @"0",
        @"pageSize": @"20",
        @"sorCol": @"defSort",
        @"pageNo": @"1"
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            DJB2CGoodsItemListModel *goodsListModel = [DJB2CGoodsItemListModel yy_modelWithDictionary:obj];
            [goodsListModel.goodsInfoList enumerateObjectsUsingBlock:^(DJGoodBaseItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.f_itemType = DJClassifyGoodItemTypeB2C;
            }];
            DJClassifyGoodsInfoModel *goodsInfoModel = [[DJClassifyGoodsInfoModel alloc]init];
            goodsInfoModel.f_itemType = DJClassifyGoodItemTypeB2C;
            goodsInfoModel.f_2rdCategoryId = categorySid;
            goodsInfoModel.f_b2CGoodsListModel = goodsListModel;
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[categorySid, goodsInfoModel]];
            [self.v2SearchForLHApiSubject sendNext:tuple];
        } else {
            [self.v2SearchForLHApiErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.v2SearchForLHApiErrorSubject sendNext:apiManager];
    }];
}

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

@end
