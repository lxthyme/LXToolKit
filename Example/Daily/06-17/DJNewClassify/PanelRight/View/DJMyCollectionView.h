//
//  DJMyCollectionView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseCollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJMyCollectionView : LXBaseCollectionView {
}
@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

NS_ASSUME_NONNULL_END
