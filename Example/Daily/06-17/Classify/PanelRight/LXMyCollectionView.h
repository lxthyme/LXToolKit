//
//  LXMyCollectionView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMyCollectionView : LXBaseCollectionView {
}
@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

NS_ASSUME_NONNULL_END