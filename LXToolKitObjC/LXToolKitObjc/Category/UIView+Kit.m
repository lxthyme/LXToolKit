//
//  UIView+Kit.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/1/6.
//

#import "UIView+Kit.h"

@implementation UIView (Kit)

/// 添加圆角
/// @param corners corners
/// @param cornerRadii cornerRadii
- (void)addCornerbyRoundingCorners:(UIRectCorner)corners
                     cornerRadii:(CGSize)cornerRadii {
    //得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/// 添加边框
/// @param position 位置
/// @param borderColor 颜色
/// @param borderWidth 宽度
- (void)addBorderWithBorderPosition:(kUIBorderPosition)position
                        borderColor:(UIColor *)borderColor
                        borderWidth:(CGFloat)borderWidth {

    UIBezierPath *path = [UIBezierPath bezierPath];
    if (position & kUIBorderPositionTop) {
        UIBezierPath *topLine = [UIBezierPath bezierPath];
        [topLine moveToPoint:CGPointZero];
        [topLine addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
        [topLine closePath];
        [path appendPath:topLine];
    }

    if (position & kUIBorderPositionLeft) {
        UIBezierPath *leftLine = [UIBezierPath bezierPath];
        [leftLine moveToPoint:CGPointZero];
        [leftLine addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
        [leftLine closePath];
        [path appendPath:leftLine];
    }

    if (position & kUIBorderPositionBottom) {
        UIBezierPath *bottomLine = [UIBezierPath bezierPath];
        [bottomLine moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
        [bottomLine addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [bottomLine closePath];
        [path appendPath:bottomLine];
    }

    if (position & kUIBorderPositionRight) {
        UIBezierPath *rightLine = [UIBezierPath bezierPath];
        [rightLine moveToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
        [rightLine addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [rightLine closePath];
        [path appendPath:rightLine];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.strokeColor = borderColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

@end
