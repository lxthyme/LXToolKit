//
//  UIView+border.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (border)

- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
           thickness:(CGFloat)thickness;

- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
               inset:(CGFloat)inset
           thickness:(CGFloat)thickness;

@end

NS_ASSUME_NONNULL_END
