//
//  UIView+Kit.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, kUIBorderPosition) {
    kUIBorderPositionTop = 1 << 0,
    kUIBorderPositionLeft = 1 << 1,
    kUIBorderPositionBottom = 1 << 2,
    kUIBorderPositionRight = 1 << 3,
};

@interface UIView (Kit)

/// 添加圆角
/// @param corners corners
/// @param cornerRadii cornerRadii
- (void)addCornerbyRoundingCorners:(UIRectCorner)corners
                     cornerRadii:(CGSize)cornerRadii;

/// 添加边框
/// @param position 位置
/// @param borderColor 颜色
/// @param borderWidth 宽度
- (void)addBorderWithBorderPosition:(kUIBorderPosition)position
                        borderColor:(UIColor *)borderColor
                        borderWidth:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END
