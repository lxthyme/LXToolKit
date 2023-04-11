//
//  UIColor+ex.h
//  LXToolKitObjc
//
//  Created by lxthyme on 2023/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ex)

+ (UIColor *)xl_colorWithHex:(NSUInteger)hex;
+ (UIColor *)xl_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
