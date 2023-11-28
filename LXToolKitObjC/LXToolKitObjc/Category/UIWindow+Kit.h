//
//  UIWindow+Kit.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (Kit)

- (UIViewController *)visibleViewController;
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
