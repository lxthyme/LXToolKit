//
//  UIView+MASSafeAreaLayoutGuide.m
//  SensorSDK_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "UIView+MASSafeAreaLayoutGuide.h"

@implementation UIView (MASSafeAreaLayoutGuide)


- (MASViewAttribute *)xl_safeAreaLayoutGuideTop {
    MASViewAttribute *topAttribute = self.mas_top;
    if (@available(iOS 11.0, *)) {
        topAttribute = self.mas_safeAreaLayoutGuideTop;
    }
    return topAttribute;
}
- (MASViewAttribute *)xl_safeAreaLayoutGuideBottom {
    MASViewAttribute *bottomAttribute = self.mas_bottom;
    if (@available(iOS 11.0, *)) {
        bottomAttribute = self.mas_safeAreaLayoutGuideBottom;
    }
    return bottomAttribute;
}
@end
