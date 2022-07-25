//
//  LXClassifyEmptyView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyEmptyView: LXBaseView {
}

/// 无数据样式
- (void)dataFillEmptyStyle;
/// 无网络样式
- (void)dataFillOfflineStyle;

@end

NS_ASSUME_NONNULL_END
