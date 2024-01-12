//
//  DJRouter.h
//  DaoJia_Example
//
//  Created by lxthyme on 2024/1/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJRouter: NSObject {
}

+ (UIViewController *)gotoMain;

+ (void)registerApp:(NSDictionary * _Nullable)launchOptions;

@end

NS_ASSUME_NONNULL_END
