//
//  iPhoneX.h
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/28.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface iPhoneX : NSObject {
}

/// 是否带有刘海
+ (BOOL)xl_isIphoneX;

+ (UIEdgeInsets)xl_safeareaInsets;

@end

NS_ASSUME_NONNULL_END
