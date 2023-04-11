//
//  UIView+MASSafeAreaLayoutGuide.h
//  SensorSDK_Example
//
//  Created by lxthyme on 2022/7/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MASSafeAreaLayoutGuide)

- (MASViewAttribute *)xl_safeAreaLayoutGuideTop;
- (MASViewAttribute *)xl_safeAreaLayoutGuideBottom;

@end

NS_ASSUME_NONNULL_END
