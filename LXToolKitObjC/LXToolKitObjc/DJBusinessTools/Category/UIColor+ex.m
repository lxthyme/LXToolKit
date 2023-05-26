//
//  UIColor+ex.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2023/4/11.
//

#import "UIColor+ex.h"
#import <Colours/Colours.h>

@implementation UIColor (ex)

+ (UIColor *)xl_colorWithHex:(NSUInteger)hex {
    return [UIColor colorFromHexString:[@(hex) stringValue]];
}

+ (UIColor *)xl_colorWithHexString:(NSString *)hexString {
    return [UIColor colorFromHexString:hexString];
}

+ (UIColor *)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

@end
