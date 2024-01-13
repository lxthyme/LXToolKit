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
NS_ASSUME_NONNULL_BEGIN

@interface DJRouter: NSObject {
}
+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

+ (void)toggleEnv;
+ (void)toggleEnvTo:(CTServiceAPIEnviroment)env;
+ (NSString *)getCurrentEnv;

+ (UIViewController *)getMain:(NSString *)storeCode storeType:(NSString *)storeType;
@end

NS_ASSUME_NONNULL_END
