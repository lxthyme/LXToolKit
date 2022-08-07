//
//  DJShopCartVM.m
//  DJGlobalStoreManager
//
//  Created by lxthyme on 2022/8/5.
//
#import "DJShopCartVM.h"
#import <BLRawAPIManager/DJNewShopCarQueryCartCouponsListAPIManager.h>
#import <BLRawAPIManager/DJNewShopCarQueryCartAPIManager.h>
#import <BLRawAPIManager/DJNewShopCarAddCartAPIManager.h>
#import <BLAPIManagers/BLDJAddCartAPIManager.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
#import <BLBusinessCategoryRouterCenter/BLMediator+BLResourceRecorder.h>
#import <IBLProgressHud/IBLProgressHud.h>

#import "DJStoreManager.h"
#import <YYModel/YYModel.h>
#import <DJBusinessTools/DJMacro.h>
@interface DJShopCartVM() {
}

@end

@implementation DJShopCartVM
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)init {
    if(self = [super init]) {
        [self prepareUI];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
- (void)loadQueryCart {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSMutableDictionary *params = [@{
        @"kdjShopId": gStore.shopId,
        @"storeIndustrySid": gStore.shopType,
        @"orderSourceCode": @"1",
        @"kdjmerchantID": gStore.merchantId,
        /// 剃除餐饮商品
        @"withOutGoodsType": @[@"27"]
    } mutableCopy];
    NSMutableDictionary *sendInfo = [NSMutableDictionary dictionary];
    if(gStore.sendType == DJGoodsSendTypeSelfRaising) {
        sendInfo[@"djSendType"] = @"1";
        params[@"djSendType"] = @"1";
    } else {
        sendInfo[@"djSendType"] = @"0";
        params[@"djSendType"] = @"0";
    }
    params[@"sendInfo"] = sendInfo;

    WEAKSELF(self)
    [DJNewShopCarQueryCartAPIManager
     loadDataWithParams:[params copy]
     success:^(CTAPIBaseManager * _Nonnull apiManager) {
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            DJQueryCartModel *queryCartModel = [DJQueryCartModel yy_modelWithDictionary:obj];
            [weakSelf.queryCartSubject sendNext:queryCartModel];
        } else {
            [weakSelf.queryCartErrorSubject sendNext:apiManager];
        }
    }
     fail:^(CTAPIBaseManager * _Nonnull apiManager) {
        [weakSelf.queryCartErrorSubject sendNext:apiManager];
    }];
}
- (void)addCartWithB2C:(DJB2CGoodItemModel *)goodItem {
    NSDictionary *paramDic = [[BLMediator sharedInstance] resourceRecordDictonary];
    NSString *deployId = stringFromObject(paramDic, @"deployId");
    NSString *resourceId = stringFromObject(paramDic, @"resourceId");
    NSString *resourceType = stringFromObject(paramDic, @"resourceType");

    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSDictionary *params = @{
        @"goodsList": @[@{
            @"type": @"",
            @"goodsName": goodItem.salesName,
            @"originalPrice": goodItem.basePrice,
            @"salePrice": goodItem.salePrice,
            @"goodsId": @(goodItem.sid),
            @"goodsNumber": @1,
            @"bl_ad": [NSString stringWithFormat:@"%@_-_%@_-_%@", resourceId, deployId, resourceType],
        }],
        @"shoppingCartType": @"",
        @"orderSourceCode": gStore.orderSourceCode,
        @"member_token": [CTAppContext sharedInstance].memberToken,
        @"type": @"",
    };
    // [IBLProgressHud show];
    [BLDJAddCartAPIManager loadDataWithParams:params
                                      success:^(CTAPIBaseManager * _Nonnull apiManager) {
        [IBLProgressHud dismiss];
        NSLog(@"apiManager: %@", apiManager);
    }
                                         fail:^(CTAPIBaseManager * _Nonnull apiManager) {
        [IBLProgressHud dismiss];
        NSLog(@"apiManager: %@", apiManager);
    }];
}
- (void)addCartWithO2O:(DJO2OGoodItemModel *)goodItem {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    
    NSDictionary *paramDic = [[BLMediator sharedInstance] resourceRecordDictonary];
    NSString *deployId = stringFromObject(paramDic, @"deployId");
    NSString *resourceId = stringFromObject(paramDic, @"resourceId");
    NSString *resourceType = stringFromObject(paramDic, @"resourceType");
    
    NSDictionary *params = @{
        @"kdjShopId": gStore.shopId,
        @"storeIndustrySid": gStore.shopType,
        @"orderSourceCode": gStore.orderSourceCode,
        @"kdjmerchantID": gStore.merchantId,
        @"goodsList":@[@{
            @"goodsId": goodItem.goodsId,
            @"goodsNumber": @1,
            @"isFromButtomShop": goodItem.tdType,
            @"rule": @"",
            @"type": @"",
            @"bl_ad": [NSString stringWithFormat:@"%@_-_%@_-_%@", resourceId, deployId, resourceType],
        }],
    };
    WEAKSELF(self)
    [IBLProgressHud show];
    [DJNewShopCarAddCartAPIManager
     loadDataWithParams:params
     success:^(CTAPIBaseManager * _Nonnull apiManager) {
        [IBLProgressHud dismiss];
        BOOL success = boolFromObject(apiManager.response.content, @"success");
        if(success) {
            NSDictionary *obj = dictionaryFromObject(apiManager.response.content, @"obj");
            DJAddCartResultModel *resultModel = [DJAddCartResultModel yy_modelWithDictionary:obj];
            [weakSelf.o2oAddCartSubject sendNext:resultModel];
        } else {
            [weakSelf.o2oAddCartErrorSubject sendNext:apiManager];
        }
    }
     fail:^(CTAPIBaseManager * _Nonnull apiManager) {
        [IBLProgressHud dismiss];
        [weakSelf.o2oAddCartErrorSubject sendNext:apiManager];
    }];
}

- (void)loadQueryCartCouponsList {
    NSDictionary *params = @{};
    [DJNewShopCarQueryCartCouponsListAPIManager
     loadDataWithParams:params
     success:^(CTAPIBaseManager * _Nonnull apiManager) {
    }
     fail:^(CTAPIBaseManager * _Nonnull apiManager) {
    }];
}
#pragma mark -
#pragma mark - 🔐Private Actions


#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareUI {
    self.queryCartSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:nil];
    self.queryCartErrorSubject = [RACSubject subject];

    self.o2oAddCartSubject = [RACSubject subject];
    self.o2oAddCartErrorSubject = [RACSubject subject];

    self.b2cAddCartSubject = [RACSubject subject];
    self.b2cAddCartErrorSubject = [RACSubject subject];
}
#pragma mark getter / setter

#pragma mark Lazy Property
@end
