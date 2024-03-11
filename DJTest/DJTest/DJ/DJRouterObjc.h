//
//  DJRouterObjc.h
//  DaoJia_Example
//
//  Created by lxthyme on 2024/1/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CTAppContext/CTAppContext.h>
#import <DJGlobalStoreManager/DJStoreManager.h>
NS_ASSUME_NONNULL_BEGIN
#pragma mark -
#pragma mark - 👀保存多环境登录信息
@interface CTAppContext (BaiLianTest)

- (NSString *)getUserInfoLocalStorageKey;
- (NSString *)getPlusLocalStorageKey;

- (void)xl_updatePlusInfo:(NSDictionary *)plusInfo;
- (void)xl_cleanPlusInfo;
- (void)xl_updateUserInfo:(NSDictionary *)userInfo;
- (void)xl_cleanUserInfo;

@end

@interface DJRouterObjc: NSObject {
}
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

+ (void)toggleEnv;
+ (void)toggleEnvTo:(CTServiceAPIEnviroment)env;
+ (CTServiceAPIEnviroment)getCurrentEnv;

+ (UIViewController *)getMain:(NSString *)storeCode storeType:(NSString *)storeType;

+ (UIViewController *)getQuickHome;

/// [全环境]显示当前缓存的登录信息 & 全局门店信息
+ (NSDictionary *)showCurrentLocalStorageInfo;
/// 迁移登录信息 & 全局门店信息到另一台设备
+ (void)backupToLocalStorage:(NSString *)localInfo;
/// 根据当前环境显示当前登录信息
+ (void)showCurrentCtxInfo;

#pragma mark -
#pragma mark - 👀备份全局门店信息
/// 将全局门店缓存到 NSUserDefaults
+ (void)saveGStore;
/// 从 NSUserDefaults 中恢复全局门店
+ (DJStoreManager *)backupGStore;

@end

NS_ASSUME_NONNULL_END
