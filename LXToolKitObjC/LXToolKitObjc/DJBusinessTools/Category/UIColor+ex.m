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

@end
