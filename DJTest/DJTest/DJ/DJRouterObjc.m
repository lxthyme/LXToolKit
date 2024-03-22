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

#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import <AvoidCrash/AvoidCrash.h>
#import <AMapFoundationKit/AMapServices.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapLocationKit/AMapLocationManager.h>
#import <MAMapKit/MAMapView.h>

#import <BLNetworkingCategory/BLMediator+BLNetwoking.h>
#import "DJQuickHomeVC.h"

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
+ (DJStoreModel *)gStore {
    return [DJStoreManager sharedInstance].storeModel;
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

- (void)xl_updatePlusInfo:(NSDictionary * _Nullable)plusInfo {
    self.plusInfo = plusInfo;
    NSLog(@"-->[CTAppContext]更新 plus 信息");
    NSString *key = [self getPlusLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] setObject:plusInfo forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

    self.plusInfo = plusInfo;
}
- (void)xl_cleanPlusInfo {
    self.plusInfo = nil;
    NSLog(@"-->[CTAppContext]清空 plus 信息");
    NSString *key = [self getPlusLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)xl_updateUserInfo:(NSDictionary * _Nullable)userInfo {
    self.userInfo = userInfo;
    NSLog(@"-->[CTAppContext]更新用户信息");
    NSString *key = [self getUserInfoLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)xl_cleanUserInfo {
    self.userInfo = nil;
    NSLog(@"-->[CTAppContext]清空用户信息");
    NSString *key = [self getUserInfoLocalStorageKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
