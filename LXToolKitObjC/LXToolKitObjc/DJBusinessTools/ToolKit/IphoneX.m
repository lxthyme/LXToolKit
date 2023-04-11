//
//  iPhoneX.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/28.
//
#import "iPhoneX.h"
#import <UIKit/UIApplication.h>

@interface iPhoneX() {
}

@end

@implementation iPhoneX

#pragma mark -
#pragma mark - 👀Public Actions
/// 是否带有刘海
+ (BOOL)xl_isIphoneX {
    return !UIEdgeInsetsEqualToEdgeInsets([self xl_safeareaInsets], UIEdgeInsetsZero);
}
+ (UIEdgeInsets)xl_safeareaInsets {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
