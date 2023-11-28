//
//  UIStackView+ex.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/10/8.
//

#import "UIStackView+ex.h"

@implementation UIStackView (ex)

- (UIView *)addBackground:(UIColor *)bgColor {
    UIView *bgView = [[UIView alloc]init];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.backgroundColor = bgColor;
    [self insertSubview:bgView atIndex:0];
    return bgView;
}
@end
