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

// - (NSString *)getUserInfoLocalStorageKey;
// - (NSString *)getPlusLocalStorageKey;

- (void)xl_updatePlusInfo:(NSDictionary * _Nullable)plusInfo;
- (void)xl_cleanPlusInfo;
- (void)xl_updateUserInfo:(NSDictionary * _Nullable)userInfo;
- (void)xl_cleanUserInfo;

@end

@interface DJRouterObjc: NSObject {
}
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

+ (UIViewController *)getQuickHome;
/// 全局门店
+ (DJStoreModel *)gStore;

@end

NS_ASSUME_NONNULL_END
