//
//  UIView+ex.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/5/27.
//

#import "UIView+ex.h"

@implementation UIView (ex)

- (void)xl_hideKeyBoard {
    // 遍历所有子视图
    [self _traverseAllSubviewsToResignFirstResponder:self];
}

//遍历父视图的所有子视图，包括嵌套的子视图
-(void)_traverseAllSubviewsToResignFirstResponder:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self _traverseAllSubviewsToResignFirstResponder:subView];
        }
        [subView resignFirstResponder];
    }
}

#pragma mark -
#pragma mark - 👀圆角 & 边框
- (void)xl_setRoundingCorners:(UIRectCorner)corners
                        raddi:(CGFloat)raddi {
    [self xl_setRoundingCorners:self.backgroundColor
                    borderWidth:0.f
                          raddi:raddi
                        corners:corners
                       isDotted:NO];
}

/// 设置圆角 & 边框
/// @param borderColor 边框颜色
/// @param borderWidth 边框宽
/// @param raddi 弧度
/// @param corners 圆角位置
/// @param isDotted 是否虚线边框
- (void)xl_setRoundingCorners:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                        raddi:(CGFloat)raddi
                      corners:(UIRectCorner)corners
                     isDotted:(BOOL)isDotted {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(raddi, raddi)];
    /// 圆角
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;

    /// 边框
    if(borderWidth > 0) {
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc]init];
        borderLayer.frame = self.bounds;
        borderLayer.path = path.CGPath;
        borderLayer.lineWidth = borderWidth;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = borderColor.CGColor;
        if(isDotted) {
            borderLayer.lineDashPattern = @[@4.f, @2.f];
        }
        [self.layer addSublayer:borderLayer];
    }
}
/// 设置边框
/// @param edges 边框位置
/// @param color 边框颜色
/// @param thickness 距离两端长度
- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
           thickness:(CGFloat)thickness {
    [self xl_addBorder:edges color:color inset:0.f thickness:thickness];
}
/// 设置边框
/// @param edges 边框位置
/// @param color 边框颜色
/// @param inset inset
/// @param thickness 距离两端长度
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

#pragma mark -
#pragma mark - 👀AutoLayout
- (void)xl_setAllHuggingAndCompression {
    [self xl_setHorizontalHuggingAndCompression];
    [self xl_setVerticalHuggingAndCompression];
}
- (void)xl_setHorizontalHuggingAndCompression {
    [self xl_setHuggingAndCompressionPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}
- (void)xl_setVerticalHuggingAndCompression {
    [self xl_setHuggingAndCompressionPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}
- (void)xl_setHuggingAndCompressionForAxis:(UILayoutConstraintAxis)axis {
    [self xl_setHuggingAndCompressionPriority:UILayoutPriorityRequired forAxis:axis];
}
- (void)xl_setHuggingAndCompressionPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    [self setContentHuggingPriority:priority forAxis:axis];
    [self setContentCompressionResistancePriority:priority forAxis:axis];
}

- (void)xl_resetAllHuggingAndCompression {
    [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}
@end
