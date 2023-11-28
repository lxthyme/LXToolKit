//
//  UIView+ex.h
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ex)

- (void)xl_hideKeyBoard;

#pragma mark -
#pragma mark - 👀圆角 & 边框
- (void)xl_setRoundingCorners:(UIRectCorner)corners
                        raddi:(CGFloat)raddi;

- (void)xl_setRoundingCorners:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                        raddi:(CGFloat)raddi
                      corners:(UIRectCorner)corners
                     isDotted:(BOOL)isDotted;

- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
           thickness:(CGFloat)thickness;

- (void)xl_addBorder:(UIRectEdge)edges
               color:(UIColor *)color
               inset:(CGFloat)inset
           thickness:(CGFloat)thickness;

#pragma mark -
#pragma mark - 👀AutoLayout
// - (void)xl_resetAllHuggingAndCompression;
- (void)xl_setAllHuggingAndCompression;
- (void)xl_setVerticalHuggingAndCompression;
- (void)xl_setHorizontalHuggingAndCompression;
- (void)xl_setHuggingAndCompressionForAxis:(UILayoutConstraintAxis)axis;
- (void)xl_setHuggingAndCompressionPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis;

@end

NS_ASSUME_NONNULL_END
