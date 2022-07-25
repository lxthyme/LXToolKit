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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CTAPIBaseManager+Rac.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import <YYModel/YYModel.h>

@interface LXB2CClassifyVM()/**<CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>*/ {
}
@property (nonatomic, strong)BLProductSearchDoCategoryByLevOneApiManager *productSearchDoCategoryByLevOneApiManager;
@property (nonatomic, strong)DJNewClassifyListSearchForLHAPIManager *v2SearchForLHApiManager;
@property (nonatomic, strong)DJNewHomeShopResourseAPIManager *shopResourseAPIManager;
@end

@implementation LXB2CClassifyVM
- (instancetype)init {
    if(self = [super init]) {
        [self prepareUI];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
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
        NSArray *obj = arrayFromObject(apiManager.response.content, @"obj");
        NSArray<LXShopResourceModel *> *shopResourceList = [NSArray yy_modelArrayWithClass:[LXShopResourceModel class] json:obj];
        LXShopResourceModel *shopResourceModel = [shopResourceList.rac_sequence filter:^BOOL(LXShopResourceModel *value) {
            return [value.resourceId isEqualToString:resourceId];
        }].head;
        [self.shopResourseSubject sendNext:shopResourceModel];
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.shopResourseSubject sendError:nil];
    }];
}
- (void)loadProductSearchDoCategoryByLevOne {
    @weakify(self)
    [self.productSearchDoCategoryByLevOneApiManager loadDataWithParams:@{
        @"parentId": @"9999300920818"
    } success:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        NSDictionary *resultInfo = dictionaryFromObject(apiManager.response.content, @"resultInfo");
        NSArray *categorys = arrayFromObject(resultInfo, @"categorys");
        NSArray<LXLHCategoryModel *> *categoryModelList = [NSArray yy_modelArrayWithClass:[LXLHCategoryModel class] json:categorys];
        [self.productSearchDoCategoryByLevOneSubject sendNext:categoryModelList];
        // [self.productSearchDoCategoryByLevOneSubject sendCompleted];
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.productSearchDoCategoryByLevOneSubject sendError:nil];
    }];
}
- (void)loadV2SearchForLHApi:(NSString *)categorySid {
    if(isEmptyString(categorySid)) {
        [self.v2SearchForLHApiSubject sendError:nil];
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
        NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
        LXGoodsInfoListModel *goodsInfoModel = [LXGoodsInfoListModel yy_modelWithDictionary:obj];
        goodsInfoModel.f_categoryId = categorySid;
        [self.v2SearchForLHApiSubject sendNext:goodsInfoModel];
        // [self.v2SearchForLHApiSubject sendCompleted];
    } fail:^(CTAPIBaseManager *apiManager) {
        @strongify(self)
        [self.v2SearchForLHApiSubject sendError:nil];
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
    self.productSearchDoCategoryByLevOneSubject = [RACSubject subject];
    self.v2SearchForLHApiSubject = [RACSubject subject];
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
-(BLProductSearchDoCategoryByLevOneApiManager *)productSearchDoCategoryByLevOneApiManager
{
    if (!_productSearchDoCategoryByLevOneApiManager) {
        BLProductSearchDoCategoryByLevOneApiManager *api = [[BLProductSearchDoCategoryByLevOneApiManager alloc]init];
        // api.delegate = self;
        // api.paramSource = self;
        _productSearchDoCategoryByLevOneApiManager = api;
    }
    return _productSearchDoCategoryByLevOneApiManager;
}
- (DJNewClassifyListSearchForLHAPIManager *)v2SearchForLHApiManager
{
    if (!_v2SearchForLHApiManager) {
        DJNewClassifyListSearchForLHAPIManager *api = [[DJNewClassifyListSearchForLHAPIManager alloc] init];
        // api.delegate = self;
        // api.paramSource = self;
        _v2SearchForLHApiManager = api;
    }
    return _v2SearchForLHApiManager;
}
- (DJNewHomeShopResourseAPIManager *)shopResourseAPIManager
{
    if (!_shopResourseAPIManager) {
        DJNewHomeShopResourseAPIManager *api = [[DJNewHomeShopResourseAPIManager alloc] init];
        // api.delegate = self;
        // api.paramSource = self;
        _shopResourseAPIManager = api;
    }
    return _shopResourseAPIManager;
}
@end
