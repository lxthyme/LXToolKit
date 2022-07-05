//
//  UIView+ex.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/7/4.
//

#import "UIView+ex.h"

@implementation UIView (ex)


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

@end
