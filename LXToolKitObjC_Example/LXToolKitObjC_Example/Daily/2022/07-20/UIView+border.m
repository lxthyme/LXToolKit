//
//  UIView+border.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "UIView+border.h"
#import <Masonry/Masonry.h>

@implementation UIView (border)

- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
           thickness:(CGFloat)thickness {
    [self xl_addBorder:edges color:color inset:0.f thickness:thickness];
}
- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
               inset:(CGFloat)inset
           thickness:(CGFloat)thickness {
    if((edges & UIRectEdgeTop)) {
        [self fmtConstraints:@[@"V:|-0-[border(==thickness)]", @"H:|-inset-[border]-inset-|"]
                       color:color
                       inset:inset
                   thickness:thickness];
    }
    if((edges & UIRectEdgeBottom)) {
        [self fmtConstraints:@[@"V:[border(==thickness)]-0-|", @"H:|-inset-[border]-inset-|"]
                       color:color
                       inset:inset
                   thickness:thickness];
    }
    if((edges & UIRectEdgeLeft)) {
        [self fmtConstraints:@[@"V:|-inset-[border]-inset-|", @"H:|-0-[border(==thickness)]"]
                       color:color
                       inset:inset
                   thickness:thickness];
    }
    if((edges & UIRectEdgeRight)) {
        [self fmtConstraints:@[@"V:|-inset-[border]-inset-|", @"H:[border(==thickness)]-0-|"]
                       color:color
                       inset:inset
                   thickness:thickness];
    }
}
- (void)fmtConstraints:(NSArray<NSString *> *)format
                 color:(UIColor *)color
                 inset:(CGFloat)inset
             thickness:(CGFloat)thickness {
    UIView *border = [[UIView alloc]init];
    border.backgroundColor = color;
    border.translatesAutoresizingMaskIntoConstraints = NO;
    [border setMas_key:@"border"];
    [self addSubview:border];
    [format enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSLayoutConstraint *> *constraints = [NSLayoutConstraint
                                                      constraintsWithVisualFormat:obj
                                                      options:0
                                                      metrics:@{ @"inset": @(inset), @"thickness": @(thickness) }
                                                      views:@{ @"border": border }];
        [self addConstraints:constraints];
    }];
}

@end
