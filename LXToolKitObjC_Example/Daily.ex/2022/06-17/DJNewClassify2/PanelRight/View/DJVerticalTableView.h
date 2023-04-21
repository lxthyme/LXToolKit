//
//  DJVerticalTableView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/31.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableView.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJVerticalTableView: LXBaseTableView {
}
@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

NS_ASSUME_NONNULL_END
