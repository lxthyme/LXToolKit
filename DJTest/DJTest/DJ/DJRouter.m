//
//  DJRouter.m
//  DaoJia_Example
//
//  Created by lxthyme on 2024/1/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//
#import "DJRouter.h"
#import <Masonry/Masonry.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
#import <BLCategories/UIColor+Hex.h>
#import <BLImage/iBLImage.h>
#import <DJBusinessTools/DJBusinessTools.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <DJBusinessModule/DJTabbarViewController.h>

#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import <AvoidCrash/AvoidCrash.h>
#import <AMapFoundationKit/AMapServices.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapLocationKit/AMapLocationManager.h>
#import <MAMapKit/MAMapView.h>

#import <BLNetworkingCategory/BLMediator+BLNetwoking.h>

#import "DJQuickHomeVC.h"

@interface DJRouter() {
}

@end

@implementation DJRouter

#pragma mark -
#pragma mark - 👀Public Actions
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions {
    [AvoidCrash becomeEffective];

    // #if defined DEBUG
    // [CTAppContext sharedInstance].apiEnviroment = CTServiceAPIEnviromentDevelop;
    // #else
    // [CTAppContext sharedInstance].apiEnviroment = CTServiceAPIEnviromentRelease;
    // #endif
    /// 从 localStorage 中恢复登录信息
    [DJRouter backupLoginfo];
    [[BLMediator sharedInstance] BLNetworking_config];

    NSString *sensorUrl = @"https://sensorsdata.bl.com/sa?project=default";
    SAConfigOptions *options = [[SAConfigOptions alloc]initWithServerURL:sensorUrl launchOptions:launchOptions];
    options.autoTrackEventType = SensorsAnalyticsEventTypeAppStart | SensorsAnalyticsEventTypeAppEnd | SensorsAnalyticsEventTypeAppViewScreen | SensorsAnalyticsEventTypeAppClick;
    [SensorsAnalyticsSDK startWithConfigOptions:options];

    [AMapServices sharedServices].enableHTTPS = YES;
    [AMapServices sharedServices].apiKey = @"e20b8e6e9aec8627532584e762ddd71e";
    [AMapLocationManager updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
    [AMapLocationManager updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
    [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [AMapSearchAPI updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
    [AMapSearchAPI updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
}

#pragma mark -
#pragma mark - 👀Public Actions
+ (void)toggleEnv {
    CTAppContext *ctx = [CTAppContext sharedInstance];
    if(ctx.apiEnviroment == CTServiceAPIEnviromentRelease) {
        [DJRouter toggleEnvTo:CTServiceAPIEnviromentDevelop];
    } else {
        [DJRouter toggleEnvTo:CTServiceAPIEnviromentRelease];
    }
}
+ (void)toggleEnvTo:(CTServiceAPIEnviroment)env {
    CTAppContext *ctx = [CTAppContext sharedInstance];
    if(ctx.apiEnviroment == env) {
        return;
    }
    [CTAppContext sharedInstance].apiEnviroment = env;
    [DJRouter backupLoginfo];
}
+ (CTServiceAPIEnviroment)getCurrentEnv {
    CTAppContext *ctx = [CTAppContext sharedInstance];
    return ctx.apiEnviroment;
}
+ (UIViewController *)getMain:(NSString *)storeCode
                    storeType:(NSString *)storeType {
    DJTabbarViewController *vc = [[DJTabbarViewController alloc]initWithDictionary:@{
        @"storeCode": storeCode,
        @"storeType": storeType,
    }];
    return vc;
}

+ (UIViewController *)getQuickHome {
    return [[DJQuickHomeVC alloc]init];
}

#pragma mark -
#pragma mark - 🔐Private Actions
/// 从 localStorage 中恢复登录信息
+ (void)backupLoginfo {
    CTAppContext *ctx = [CTAppContext sharedInstance];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoKey = [ctx getUserInfoLocalStorageKey];
    ctx.userInfo = [defaults dictionaryForKey:userInfoKey];
    NSString *plusKey = [ctx getPlusLocalStorageKey];
    ctx.plusInfo = [defaults dictionaryForKey:plusKey];
}

#pragma mark -
#pragma mark - 👀备份全局门店信息
+ (NSString *)getEnvLocalStorageKey {
    CTServiceAPIEnviroment env = [DJRouter getCurrentEnv];
    NSMutableString *key = [@"DJTest.gStore." mutableCopy];
    switch(env) {
    case CTServiceAPIEnviromentDevelop: {
        [key appendString:@"develop"];
    } break;
    case CTServiceAPIEnviromentPreRelease: {
        [key appendString:@"beta"];
    } break;
    default: {
        [key appendString:@"release"];
    } break;
    }
    return key;
}
+ (void)saveToJSON {
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    NSDictionary *json = [gStore yy_modelToJSONObject];
    NSString *key = [DJRouter getEnvLocalStorageKey];
    [[NSUserDefaults standardUserDefaults]setValue:json forKey:key];
}
+ (DJStoreManager *)backupFromJSON {
    NSString *key = [DJRouter getEnvLocalStorageKey];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    DJStoreManager *model = [DJStoreManager yy_modelWithJSON:jsonString];
    DJStoreManager *gStore = [DJStoreManager sharedInstance];
    if(gStore.storeModel) {
        [DJRouter checkEqual:gStore model:model];
    }
    gStore.sendType = model.sendType;
    gStore.sceneId = model.sceneId;
    gStore.longtitude = model.longtitude;
    gStore.latitude = model.latitude;
    gStore.currentAddress = model.currentAddress;
    gStore.addressRawDic = model.addressRawDic;
    gStore.orderSourceCode = model.orderSourceCode;
    gStore.nearShopListArr = model.nearShopListArr;
    gStore.locationAdress = model.locationAdress;
    gStore.locationCity = model.locationCity;
    gStore.bl_ad = model.bl_ad;
    gStore.djHomeStyle = model.djHomeStyle;
    gStore.isChangeNet = model.isChangeNet;
    gStore.isDaoJiaApp = model.isDaoJiaApp;
    gStore.djHomeSearchStr = model.djHomeSearchStr;
    gStore.djModuleType = model.djModuleType;
    gStore.sourceValue = model.sourceValue;
    gStore.packageArray = model.packageArray;
    gStore.isDeveloper = model.isDeveloper;
    gStore.developerLatitude = model.developerLatitude;
    gStore.developerLongtitude = model.developerLongtitude;
    gStore.djClassifyHeaderType = model.djClassifyHeaderType;
    gStore.headerBgColorStr = model.headerBgColorStr;
    gStore.head4FCDefColor = model.head4FCDefColor;
    gStore.head4FCActiveColor = model.head4FCActiveColor;
    gStore.labelColor = model.labelColor;
    gStore.classifyShowIndex = model.classifyShowIndex;
    gStore.isFirstShowClassify = model.isFirstShowClassify;
    gStore.leaveDJTimeStr = model.leaveDJTimeStr;
    // gStore.storeModel = model.storeModel;
    gStore.sceneQueryModel = model.sceneQueryModel;
    // gStore.storeDictionary = model.storeDictionary;
    gStore.inStoreStyle = model.inStoreStyle;
    gStore.tdStoreModel = model.tdStoreModel;
    gStore.shopCart_storeModel = model.shopCart_storeModel;
    gStore.shopCart_tdStoreModel = model.shopCart_tdStoreModel;
    gStore.headType = model.headType;
    gStore.homeSelectTabType = model.homeSelectTabType;
    [gStore storeMessageTransform:[model.storeModel yy_modelToJSONObject]];

    return model;
}
+ (void)checkEqual:(DJStoreManager *)gStore model:(DJStoreManager *)model {
    BOOL eq_sendType = gStore.sendType == model.sendType;
    BOOL eq_sceneId = gStore.sceneId == model.sceneId || [gStore.sceneId isEqualToString:model.sceneId];
    BOOL eq_longtitude = gStore.longtitude == model.longtitude || [gStore.longtitude isEqualToString:model.longtitude];
    BOOL eq_latitude = gStore.latitude == model.latitude || [gStore.latitude isEqualToString:model.latitude];
    BOOL eq_currentAddress = gStore.currentAddress == model.currentAddress || [gStore.currentAddress isEqualToString:model.currentAddress];
    BOOL eq_addressRawDic = [gStore.addressRawDic isEqual:model.addressRawDic];
    BOOL eq_orderSourceCode = gStore.orderSourceCode == model.orderSourceCode || [gStore.orderSourceCode isEqualToString:model.orderSourceCode];
    BOOL eq_nearShopListArr = [gStore.nearShopListArr isEqual:model.nearShopListArr];
    BOOL eq_locationAdress = gStore.locationAdress == model.locationAdress || [gStore.locationAdress isEqualToString:model.locationAdress];
    BOOL eq_locationCity = gStore.locationCity == model.locationCity || [gStore.locationCity isEqualToString:model.locationCity];
    BOOL eq_bl_ad = gStore.bl_ad == model.bl_ad || [gStore.bl_ad isEqualToString:model.bl_ad];
    BOOL eq_djHomeStyle = gStore.djHomeStyle == model.djHomeStyle;
    BOOL eq_isChangeNet = gStore.isChangeNet == model.isChangeNet;
    BOOL eq_isDaoJiaApp = gStore.isDaoJiaApp == model.isDaoJiaApp;
    BOOL eq_djHomeSearchStr = gStore.djHomeSearchStr == model.djHomeSearchStr || [gStore.djHomeSearchStr isEqualToString:model.djHomeSearchStr];
    BOOL eq_djModuleType = gStore.djModuleType == model.djModuleType;
    BOOL eq_sourceValue = gStore.sourceValue == model.sourceValue || [gStore.sourceValue isEqualToString:model.sourceValue];
    BOOL eq_packageArray = gStore.packageArray.count == model.packageArray.count;
    BOOL eq_isDeveloper = gStore.isDeveloper == model.isDeveloper;
    BOOL eq_developerLatitude = gStore.developerLatitude == model.developerLatitude || [gStore.developerLatitude isEqualToString:model.developerLatitude];
    BOOL eq_developerLongtitude = gStore.developerLongtitude == model.developerLongtitude || [gStore.developerLongtitude isEqualToString:model.developerLongtitude];
    BOOL eq_djClassifyHeaderType = gStore.djClassifyHeaderType == model.djClassifyHeaderType;
    BOOL eq_headerBgColorStr = gStore.headerBgColorStr == model.headerBgColorStr || [gStore.headerBgColorStr isEqualToString:model.headerBgColorStr];
    BOOL eq_head4FCDefColor = gStore.head4FCDefColor == model.head4FCDefColor || [gStore.head4FCDefColor isEqualToString:model.head4FCDefColor];
    BOOL eq_head4FCActiveColor = gStore.head4FCActiveColor == model.head4FCActiveColor || [gStore.head4FCActiveColor isEqualToString:model.head4FCActiveColor];
    BOOL eq_labelColor = gStore.labelColor == model.labelColor || [gStore.labelColor isEqualToString:model.labelColor];
    BOOL eq_classifyShowIndex = gStore.classifyShowIndex == model.classifyShowIndex;
    BOOL eq_isFirstShowClassify = gStore.isFirstShowClassify == model.isFirstShowClassify;
    BOOL eq_leaveDJTimeStr = gStore.leaveDJTimeStr == model.leaveDJTimeStr;
    BOOL eq_storeModel = [gStore.storeModel isSameStoreWith:model.storeModel];
    BOOL eq_sceneQueryModel = [gStore.sceneQueryModel isEqual:model.sceneQueryModel];
    BOOL eq_storeDictionary = [gStore.storeDictionary isEqual:model.storeDictionary];
    BOOL eq_inStoreStyle = gStore.inStoreStyle == model.inStoreStyle;
    BOOL eq_tdStoreModel = [gStore.tdStoreModel isEqual:model.tdStoreModel];
    BOOL eq_shopCart_storeModel = [gStore.shopCart_storeModel isEqual:model.shopCart_storeModel];
    BOOL eq_shopCart_tdStoreModel = [gStore.shopCart_tdStoreModel isEqual:model.shopCart_tdStoreModel];
    BOOL eq_headType = gStore.headType == model.headType;
    BOOL eq_homeSelectTabType = gStore.homeSelectTabType == model.homeSelectTabType;
    BOOL success = eq_sendType
    && eq_sceneId
    && eq_longtitude
    && eq_latitude
    && eq_currentAddress
    && eq_addressRawDic
    && eq_orderSourceCode
    && eq_nearShopListArr
    && eq_locationAdress
    && eq_locationCity
    && eq_bl_ad
    && eq_djHomeStyle
    && eq_isChangeNet
    && eq_isDaoJiaApp
    && eq_djHomeSearchStr
    && eq_djModuleType
    && eq_sourceValue
    && eq_packageArray
    && eq_isDeveloper
    && eq_developerLatitude
    && eq_developerLongtitude
    && eq_djClassifyHeaderType
    && eq_headerBgColorStr
    && eq_head4FCDefColor
    && eq_head4FCActiveColor
    && eq_labelColor
    && eq_classifyShowIndex
    && eq_isFirstShowClassify
    // && eq_leaveDJTimeStr
    && eq_storeModel
    // && eq_sceneQueryModel
    // && eq_storeDictionary
    && eq_inStoreStyle
    // && eq_tdStoreModel
    // && eq_shopCart_storeModel
    // && eq_shopCart_tdStoreModel
    && eq_headType
    && eq_homeSelectTabType;
    if(success) {
        return;
    }
    NSMutableString *result = [NSMutableString string];
    if(!eq_sendType) { [result appendFormat:@"eq_sendType: %@\n", kBOOLString(eq_sendType)]; }
    if(!eq_sceneId) { [result appendFormat:@"eq_sceneId: %@\n", kBOOLString(eq_sceneId)]; }
    if(!eq_longtitude) { [result appendFormat:@"eq_longtitude: %@\n", kBOOLString(eq_longtitude)]; }
    if(!eq_latitude) { [result appendFormat:@"eq_latitude: %@\n", kBOOLString(eq_latitude)]; }
    if(!eq_currentAddress) { [result appendFormat:@"eq_currentAddress: %@\n", kBOOLString(eq_currentAddress)]; }
    if(!eq_addressRawDic) { [result appendFormat:@"eq_addressRawDic: %@\n", kBOOLString(eq_addressRawDic)]; }
    if(!eq_orderSourceCode) { [result appendFormat:@"eq_orderSourceCode: %@\n", kBOOLString(eq_orderSourceCode)]; }
    if(!eq_nearShopListArr) { [result appendFormat:@"eq_nearShopListArr: %@\n", kBOOLString(eq_nearShopListArr)]; }
    if(!eq_locationAdress) { [result appendFormat:@"eq_locationAdress: %@\n", kBOOLString(eq_locationAdress)]; }
    if(!eq_locationCity) { [result appendFormat:@"eq_locationCity: %@\n", kBOOLString(eq_locationCity)]; }
    if(!eq_bl_ad) { [result appendFormat:@"eq_bl_ad: %@\n", kBOOLString(eq_bl_ad)]; }
    if(!eq_djHomeStyle) { [result appendFormat:@"eq_djHomeStyle: %@\n", kBOOLString(eq_djHomeStyle)]; }
    if(!eq_isChangeNet) { [result appendFormat:@"eq_isChangeNet: %@\n", kBOOLString(eq_isChangeNet)]; }
    if(!eq_isDaoJiaApp) { [result appendFormat:@"eq_isDaoJiaApp: %@\n", kBOOLString(eq_isDaoJiaApp)]; }
    if(!eq_djHomeSearchStr) { [result appendFormat:@"eq_djHomeSearchStr: %@\n", kBOOLString(eq_djHomeSearchStr)]; }
    if(!eq_djModuleType) { [result appendFormat:@"eq_djModuleType: %@\n", kBOOLString(eq_djModuleType)]; }
    if(!eq_sourceValue) { [result appendFormat:@"eq_sourceValue: %@\n", kBOOLString(eq_sourceValue)]; }
    if(!eq_packageArray) { [result appendFormat:@"eq_packageArray: %@\n", kBOOLString(eq_packageArray)]; }
    if(!eq_isDeveloper) { [result appendFormat:@"eq_isDeveloper: %@\n", kBOOLString(eq_isDeveloper)]; }
    if(!eq_developerLatitude) { [result appendFormat:@"eq_developerLatitude: %@\n", kBOOLString(eq_developerLatitude)]; }
    if(!eq_developerLongtitude) { [result appendFormat:@"eq_developerLongtitude: %@\n", kBOOLString(eq_developerLongtitude)]; }
    if(!eq_djClassifyHeaderType) { [result appendFormat:@"eq_djClassifyHeaderType: %@\n", kBOOLString(eq_djClassifyHeaderType)]; }
    if(!eq_headerBgColorStr) { [result appendFormat:@"eq_headerBgColorStr: %@\n", kBOOLString(eq_headerBgColorStr)]; }
    if(!eq_head4FCDefColor) { [result appendFormat:@"eq_head4FCDefColor: %@\n", kBOOLString(eq_head4FCDefColor)]; }
    if(!eq_head4FCActiveColor) { [result appendFormat:@"eq_head4FCActiveColor: %@\n", kBOOLString(eq_head4FCActiveColor)]; }
    if(!eq_labelColor) { [result appendFormat:@"eq_labelColor: %@\n", kBOOLString(eq_labelColor)]; }
    if(!eq_classifyShowIndex) { [result appendFormat:@"eq_classifyShowIndex: %@\n", kBOOLString(eq_classifyShowIndex)]; }
    if(!eq_isFirstShowClassify) { [result appendFormat:@"eq_isFirstShowClassify: %@\n", kBOOLString(eq_isFirstShowClassify)]; }
    if(!eq_leaveDJTimeStr) { [result appendFormat:@"eq_leaveDJTimeStr: %@\n", kBOOLString(eq_leaveDJTimeStr)]; }
    if(!eq_storeModel) { [result appendFormat:@"eq_storeModel: %@\n", kBOOLString(eq_storeModel)]; }
    if(!eq_sceneQueryModel) { [result appendFormat:@"eq_sceneQueryModel: %@\n", kBOOLString(eq_sceneQueryModel)]; }
    if(!eq_storeDictionary) { [result appendFormat:@"eq_storeDictionary: %@\n", kBOOLString(eq_storeDictionary)]; }
    if(!eq_inStoreStyle) { [result appendFormat:@"eq_inStoreStyle: %@\n", kBOOLString(eq_inStoreStyle)]; }
    if(!eq_tdStoreModel) { [result appendFormat:@"eq_tdStoreModel: %@\n", kBOOLString(eq_tdStoreModel)]; }
    if(!eq_shopCart_storeModel) { [result appendFormat:@"eq_shopCart_storeModel: %@\n", kBOOLString(eq_shopCart_storeModel)]; }
    if(!eq_shopCart_tdStoreModel) { [result appendFormat:@"eq_shopCart_tdStoreModel: %@\n", kBOOLString(eq_shopCart_tdStoreModel)]; }
    if(!eq_headType) { [result appendFormat:@"eq_headType: %@\n", kBOOLString(eq_headType)]; }
    if(!eq_homeSelectTabType) { [result appendFormat:@"eq_homeSelectTabType: %@\n", kBOOLString(eq_homeSelectTabType)]; }
    NSLog(@"result: \n%@", result);
}
#pragma mark -
#pragma mark - 🔐Private Actions

@end

#pragma mark -
#pragma mark - 👀添加黑名单(防止 json 转换异常)
@interface DJStoreManager (addBlackList)
@end

@implementation DJStoreManager (addBlackList)
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    return @[
        @"djqueryFastCartGroupAPIManager"
    ];
}
@end

#pragma mark -
#pragma mark - 👀保存多环境登录信息
@implementation CTAppContext (BaiLianTest)
+(void)load {
    Method method3 = class_getInstanceMethod([self class], @selector(updatePlusInfo:));
    Method method4 = class_getInstanceMethod([self class], @selector(xl_updatePlusInfo:));
    method_exchangeImplementations(method3, method4);

    Method method5 = class_getInstanceMethod([self class], @selector(cleanPlusInfo));
    Method method6 = class_getInstanceMethod([self class], @selector(xl_cleanPlusInfo));
    method_exchangeImplementations(method5, method6);

    Method method7 = class_getInstanceMethod([self class], @selector(updateUserInfo:));
    Method method8 = class_getInstanceMethod([self class], @selector(xl_updateUserInfo:));
    method_exchangeImplementations(method7, method8);

    Method method9 = class_getInstanceMethod([self class], @selector(cleanUserInfo));
    Method method10 = class_getInstanceMethod([self class], @selector(xl_cleanUserInfo));
    method_exchangeImplementations(method9, method10);
}
- (NSString *)getLoginLocalStorageKey {
    CTServiceAPIEnviroment env = [DJRouter getCurrentEnv];
    NSMutableString *key = [@"DJTest.gStore." mutableCopy];
    switch(env) {
    case CTServiceAPIEnviromentDevelop: {
        [key appendString:@"develop"];
    } break;
    case CTServiceAPIEnviromentPreRelease: {
        [key appendString:@"beta"];
    } break;
    default: {
        [key appendString:@"release"];
    } break;
    }
    return key;
}
/// kBaiLianCTAppContextKeyPlusInfo
- (NSString *)getPlusLocalStorageKey {
    NSString *key = [self getLoginLocalStorageKey];
    return [NSString stringWithFormat:@"%@.plus", key];
}
/// kCTAppContextUserDefaultKeyUserInfo
- (NSString *)getUserInfoLocalStorageKey {
    NSString *key = [self getLoginLocalStorageKey];
    return [NSString stringWithFormat:@"%@.userInfo", key];
}

- (void)xl_updatePlusInfo:(NSDictionary *)plusInfo {
    self.plusInfo = plusInfo;

    NSString *key = [self getPlusLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] setObject:plusInfo forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

    self.plusInfo = plusInfo;
}
- (void)xl_cleanPlusInfo {
    self.plusInfo = nil;

    NSString *key = [self getPlusLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)xl_updateUserInfo:(NSDictionary *)userInfo {
    self.userInfo = userInfo;

    NSString *key = [self getUserInfoLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)xl_cleanUserInfo {
    self.userInfo = nil;

    NSString *key = [self getUserInfoLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
