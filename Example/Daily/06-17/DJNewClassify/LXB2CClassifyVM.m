//
//  LXB2CClassifyVM.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXB2CClassifyVM.h"
#import <BLAPIManagers/BLProductSearchDoCategoryByLevOneApiManager.h>
#import <BLRawAPIManager/DJNewClassifyListSearchForLHAPIManager.h>
#import <BLRawAPIManager/DJNewHomeShopResourseAPIManager.h>
#import <BLRawAPIManager/DJNewClassifyKdjShopCategoryAPIManager.h>
#import <BLRawAPIManager/DJGoodsSearchGoodsIdsAPIManager.h>
#import <BLRawAPIManager/DJGoodsSearchGoodsDetailsAPIManager.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CTAPIBaseManager+Rac.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import <YYModel/YYModel.h>

@interface LXB2CClassifyVM()/**<CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>*/ {
}
@property (nonatomic, strong)DJNewHomeShopResourseAPIManager *shopResourseAPIManager;
@property (nonatomic, strong)BLProductSearchDoCategoryByLevOneApiManager *productSearchDoCategoryByLevOneApiManager;
@property (nonatomic, strong)DJNewClassifyListSearchForLHAPIManager *v2SearchForLHApiManager;
@property (nonatomic, strong)DJNewClassifyKdjShopCategoryAPIManager *shopCategoryAPIManager;
@property (nonatomic, strong)DJGoodsSearchGoodsIdsAPIManager *searchGoodsIdsAPIManager;
@property (nonatomic, strong)DJGoodsSearchGoodsDetailsAPIManager *searchGoodsDetailsAPIManager;

@property(nonatomic, strong)RACSubject *searchGoodsIdsSubject;
@property(nonatomic, strong)RACSubject *searchGoodsIdsErrorSubject;

@end

@implementation LXB2CClassifyVM
- (instancetype)init {
    if(self = [super init]) {
        [CTAppContext sharedInstance].apiEnviroment = CTServiceAPIEnviromentDevelop;
        [self prepareUI];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
/// 查询分类标题
- (void)loadShopResource {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSString *resourceId = @"2019724";

    @weakify(self)
    [self.shopResourseAPIManager loadDataWithParams:@{
        @"channelId": @1,
        @"merchantId": gStore.merchantId,
        @"resourceIds": resourceId,
        @"status": @4,
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
            NSArray<LXShopResourceModel *> *shopResourceList = [NSArray yy_modelArrayWithClass:[LXShopResourceModel class] json:obj];
            LXShopResourceModel *shopResourceModel = [shopResourceList.rac_sequence filter:^BOOL(LXShopResourceModel *value) {
                return [value.resourceId isEqualToString:resourceId];
            }].head;
            [self.shopResourseSubject sendNext:shopResourceModel];
        } else {
            [self.shopCategoryErrorSubject sendNext:apiManager];
        }
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.shopResourseErrorSubject sendNext:apiManager];
    }];
}

/// 查询 O2O 目录
- (void)loadShopCategory {
    @weakify(self)
    [self.shopCategoryAPIManager loadDataWithParams:@{
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
- (void)loadD {
    [self.searchGoodsIdsSubject subscribeNext:^(id x) {
    }];
    [self.searchGoodsIdsAPIManager loadDataWithParams:@{} success:^(CTAPIBaseManager *apiManager) {

    } fail:^(CTAPIBaseManager *apiManager) {
    }];
}

/// 查询 B2C 目录
- (void)loadProductSearchDoCategoryByLevOne {
    @weakify(self)
    [self.productSearchDoCategoryByLevOneApiManager loadDataWithParams:@{
        @"parentId": @"9999300920818"
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *resultInfo = dictionaryFromObject(apiManager.response.content, @"resultInfo");
            NSArray *categorys = arrayFromObject(resultInfo, @"categorys");
            NSArray<LXLHCategoryModel *> *categoryModelList = [NSArray yy_modelArrayWithClass:[LXLHCategoryModel class] json:categorys];
            [self.productSearchDoCategoryByLevOneSubject sendNext:categoryModelList];
            // [self.productSearchDoCategoryByLevOneSubject sendCompleted];
        } else {
            [self.shopCategoryErrorSubject sendNext:apiManager];
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
    [self.v2SearchForLHApiManager loadDataWithParams:@{
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
            LXB2CGoodsItemListModel *goodsInfoModel = [LXB2CGoodsItemListModel yy_modelWithDictionary:obj];
            goodsInfoModel.f_categoryId = categorySid;
            [self.v2SearchForLHApiSubject sendNext:goodsInfoModel];
            // [self.v2SearchForLHApiSubject sendCompleted];
        } else {
            [self.shopCategoryErrorSubject sendNext:apiManager];
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
    self.searchGoodsDetailsSubject = [RACSubject subject];
    self.searchGoodsDetailsErrorSubject = [RACSubject subject];
    self.searchGoodsIdsSubject = [RACSubject subject];
    self.searchGoodsIdsErrorSubject = [RACSubject subject];

    self.productSearchDoCategoryByLevOneSubject = [RACSubject subject];
    self.productSearchDoCategoryByLevOneErrorSubject = [RACSubject subject];
    self.v2SearchForLHApiSubject = [RACSubject subject];
    self.v2SearchForLHApiErrorSubject = [RACSubject subject];
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
-(BLProductSearchDoCategoryByLevOneApiManager *)productSearchDoCategoryByLevOneApiManager {
    if (!_productSearchDoCategoryByLevOneApiManager) {
        BLProductSearchDoCategoryByLevOneApiManager *api = [[BLProductSearchDoCategoryByLevOneApiManager alloc]init];
        // api.delegate = self;
        // api.paramSource = self;
        _productSearchDoCategoryByLevOneApiManager = api;
    }
    return _productSearchDoCategoryByLevOneApiManager;
}
- (DJNewClassifyListSearchForLHAPIManager *)v2SearchForLHApiManager {
    if (!_v2SearchForLHApiManager) {
        DJNewClassifyListSearchForLHAPIManager *api = [[DJNewClassifyListSearchForLHAPIManager alloc] init];
        // api.delegate = self;
        // api.paramSource = self;
        _v2SearchForLHApiManager = api;
    }
    return _v2SearchForLHApiManager;
}
- (DJNewHomeShopResourseAPIManager *)shopResourseAPIManager {
    if (!_shopResourseAPIManager) {
        DJNewHomeShopResourseAPIManager *api = [[DJNewHomeShopResourseAPIManager alloc] init];
        // api.delegate = self;
        // api.paramSource = self;
        _shopResourseAPIManager = api;
    }
    return _shopResourseAPIManager;
}
- (DJNewClassifyKdjShopCategoryAPIManager *)shopCategoryAPIManager {
    if(!_shopCategoryAPIManager){
        DJNewClassifyKdjShopCategoryAPIManager *v = [[DJNewClassifyKdjShopCategoryAPIManager alloc]init];
        _shopCategoryAPIManager = v;
    }
    return _shopCategoryAPIManager;
}
- (DJGoodsSearchGoodsIdsAPIManager *)searchGoodsIdsAPIManager {
    if(!_searchGoodsIdsAPIManager){
        DJGoodsSearchGoodsIdsAPIManager *v = [[DJGoodsSearchGoodsIdsAPIManager alloc]init];
        _searchGoodsIdsAPIManager = v;
    }
    return _searchGoodsIdsAPIManager;
}
- (DJGoodsSearchGoodsDetailsAPIManager *)searchGoodsDetailsAPIManager {
    if(!_searchGoodsDetailsAPIManager){
        DJGoodsSearchGoodsDetailsAPIManager *v = [[DJGoodsSearchGoodsDetailsAPIManager alloc]init];
        _searchGoodsDetailsAPIManager = v;
    }
    return _searchGoodsDetailsAPIManager;
}
@end
