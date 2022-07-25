//
//  UIViewController+ex.h
//  SensorSDK_Example
//
//  Created by lxthyme on 2022/7/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ex)

+ (UIViewController*)topMostController;

- (UIViewController*)topViewController;

@end

NS_ASSUME_NONNULL_END
