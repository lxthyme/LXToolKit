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
        ctx.apiEnviroment = CTServiceAPIEnviromentDevelop;
    } else {
        ctx.apiEnviroment = CTServiceAPIEnviromentRelease;
    }
}
+ (void)toggleEnvTo:(CTServiceAPIEnviroment)env {
    [CTAppContext sharedInstance].apiEnviroment = env;
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

@end
