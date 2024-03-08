//
//  DJRouter.h
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

@end

@interface DJRouter: NSObject {
}
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

+ (void)toggleEnv;
+ (void)toggleEnvTo:(CTServiceAPIEnviroment)env;
+ (CTServiceAPIEnviroment)getCurrentEnv;

+ (UIViewController *)getMain:(NSString *)storeCode storeType:(NSString *)storeType;

+ (UIViewController *)getQuickHome;

#pragma mark -
#pragma mark - 👀备份全局门店信息
+ (void)saveToJSON;
+ (DJStoreManager *)backupFromJSON;

@end

NS_ASSUME_NONNULL_END
