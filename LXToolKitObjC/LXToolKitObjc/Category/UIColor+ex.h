//
//  UIColor+ex.h
//  LXToolKitObjC
//
//  Created by lxthyme on 2023/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ex)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *)xl_colorWithHex:(NSUInteger)hex;
+ (UIColor *)xl_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
