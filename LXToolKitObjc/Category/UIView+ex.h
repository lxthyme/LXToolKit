//
//  UIView+ex.h
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ex)

- (void)xl_hideKeyBoard;

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
                     isDotted:(BOOL)isDotted;

@end

NS_ASSUME_NONNULL_END
