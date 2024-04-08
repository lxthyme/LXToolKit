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

// - (void)xl_updatePlusInfo2:(NSDictionary * _Nullable)plusInfo;
// - (void)xl_cleanPlusInfo2;
// - (void)xl_updateUserInfo2:(NSDictionary * _Nullable)userInfo;
// - (void)xl_cleanUserInfo2;

@end

@interface DJRouterObjc: NSObject {
}
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

+ (UIViewController *)getQuickHome;
/// 全局门店
// + (DJStoreModel *)gStore;

@end

NS_ASSUME_NONNULL_END
