//
//  DJRouterObjc.m
//  DaoJia_Example
//
//  Created by lxthyme on 2024/1/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//
#import "DJRouterObjc.h"
#import <Masonry/Masonry.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
#import <BLCategories/UIColor+Hex.h>
#import <BLImage/iBLImage.h>
#import <DJBusinessTools/DJBusinessTools.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <DJBusinessModule/DJTabbarViewController.h>
#import <DJBusinessModule/DJNewOrderListViewController.h>
#import <DJBusinessModule/DJNearStoresViewController.h>

#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import <AvoidCrash/AvoidCrash.h>
#import <AMapFoundationKit/AMapServices.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapLocationKit/AMapLocationManager.h>
#import <MAMapKit/MAMapView.h>

#import <BLNetworkingCategory/BLMediator+BLNetwoking.h>
#import "DJQuickHomeVC.h"
#import "SmAntiFraud.h"

@interface DJRouterObjc() {
}

@end

@implementation DJRouterObjc

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
    // [DJRouterObjc backupAllInfo];
    [[BLMediator sharedInstance] BLNetworking_config];

    /*
     数美
     */
    SmOption *option = [[SmOption alloc] init];
    [option setOrganization: @"niZzPzSqVrYmUv78jU0D"];
    [option setAppId:@"default"];
    [option setPublicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCHOh6HqQreWYb8eS8QZmy3+H2cbm7ZddIUcJ2wGiSS3FGyHfuraTA6HyI7DmbH9qfjasaJMseXBq2Dnau4v881acgag4IHxEjDQiJalic++Yp/MSTrmPsqVWNom/Myk7/77X1Zr9m2oF3JYFeRAGEsNNfbfttHlxEu64G1hIc9TwIDAQAB"];
    [[SmAntiFraud shareInstance] create:option];

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
+ (UIViewController *)getQuickHome {
    return [[DJQuickHomeVC alloc]init];
}
// + (DJStoreModel *)gStore {
//     return [DJStoreManager sharedInstance].storeModel;
// }
+ (UIViewController *)getShopListVC:(NSString *)sceneId 
                        complection:(void(^)(void))complectionBlock {
    [DJStoreManager sharedInstance].sceneId = sceneId;
    DJNearStoresViewController *vc = [[DJNearStoresViewController alloc] init];
    vc.changeHomePage = ^(NSDictionary *parames) {
        !complectionBlock ?: complectionBlock();
    };
    return vc;
}
+ (UIViewController *)getOrderListVC {
    DJNewOrderListViewController *vc = [[DJNewOrderListViewController alloc]init];
    vc.isMainToSanBarcodeList = NO;
    return vc;
}

#pragma mark -
#pragma mark - 🔐Private Actions
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

// - (void)xl_updatePlusInfo:(NSDictionary * _Nullable)plusInfo {
//     self.plusInfo = plusInfo;
//     NSLog(@"-->[CTAppContext]更新 plus 信息");
//     NSString *key = [self getLocalPlusInfoKey:self.apiEnviroment];
//     [[NSUserDefaults standardUserDefaults] setObject:plusInfo forKey:key];
//     [[NSUserDefaults standardUserDefaults] synchronize];
// 
//     self.plusInfo = plusInfo;
// }
// - (void)xl_cleanPlusInfo {
//     self.plusInfo = nil;
//     NSLog(@"-->[CTAppContext]清空 plus 信息");
//     NSString *key = [self getLocalPlusInfoKey:self.apiEnviroment];
//     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//     [[NSUserDefaults standardUserDefaults] synchronize];
// }
// 
// - (void)xl_updateUserInfo:(NSDictionary * _Nullable)userInfo {
//     self.userInfo = userInfo;
//     NSLog(@"-->[CTAppContext]更新用户信息");
//     NSString *key = [self getLocalUserInfoKey:self.apiEnviroment];
//     [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:key];
//     [[NSUserDefaults standardUserDefaults] synchronize];
// }
// 
// - (void)xl_cleanUserInfo {
//     self.userInfo = nil;
//     NSLog(@"-->[CTAppContext]清空用户信息");
//     NSString *key = [self getLocalUserInfoKey:self.apiEnviroment];
//     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//     [[NSUserDefaults standardUserDefaults] synchronize];
// }
// 
// - (NSString *)getLocalUserInfoKey:(CTServiceAPIEnviroment)env {
//     return [self getLocalKey:env title:@"userInfo"];
// }
// - (NSString *)getLocalPlusInfoKey:(CTServiceAPIEnviroment)env {
//     return [self getLocalKey:env title:@"plusInfo"];
// }
// - (NSString *)getLocalKey:(CTServiceAPIEnviroment)env title:(NSString *)title {
//     NSString *envString = @"release";
//     switch(env) {
//     case CTServiceAPIEnviromentDevelop: {
//         envString = @"title";
//     } break;
//     case CTServiceAPIEnviromentPreRelease: {
//         envString = @"beta";
//     }
//     default: break;
//     }
//     return [NSString stringWithFormat:@"DJTest.%@.%@", envString, title];
// }

@end

@interface SmAntiFraud (BaiLianTest)

// - (void)xl_updatePlusInfo2:(NSDictionary * _Nullable)plusInfo;
// - (void)xl_cleanPlusInfo2;
// - (void)xl_updateUserInfo2:(NSDictionary * _Nullable)userInfo;
// - (void)xl_cleanUserInfo2;

@end
@implementation SmAntiFraud (BaiLianTest)
+(void)load {
    Method method3 = class_getInstanceMethod([self class], @selector(getDeviceId));
    Method method4 = class_getInstanceMethod([self class], @selector(xl_getDeviceId));
    method_exchangeImplementations(method3, method4);
}

- (NSString* )xl_getDeviceId {
    return @"BpCmSFzs52FUE/MUL/GnN1w6svbaXrBl3C0ZcTyU/ucxr8WBFnwOM/WMhvC9X0LBCPY3iTUgH+tIwirGfpwJndQ==";
}
@end
