//
//  UIFont+ex.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/19.
//

#import "UIFont+ex.h"

@implementation UIFont (ex)

+ (UIFont *)misansFontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"misans" size:size];
    if(!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
@end
