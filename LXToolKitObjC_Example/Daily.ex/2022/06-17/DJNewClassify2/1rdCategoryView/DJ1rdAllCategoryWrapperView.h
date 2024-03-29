//
//  DJ1rdAllCategoryWrapperView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJ1rdAllCategoryWrapperView: UIControl {
}

- (void)showWithContainerView:(UIView *)containerView topConstraint:(MASViewAttribute *)topConstraint;
- (void)dismissFirstCategoryView;

@end

NS_ASSUME_NONNULL_END
