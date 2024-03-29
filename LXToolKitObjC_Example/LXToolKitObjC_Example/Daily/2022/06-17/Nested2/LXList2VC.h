//
//  LXList2VC.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXPagingView/JXPagerView.h>
#import "LXMyTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXList2VC : UIViewController<JXPagerViewListViewDelegate> {
}
@property (nonatomic, strong)LXMyTableView *tableView;
@property (nonatomic, strong)NSMutableArray<NSString *> *dataSource;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
/// 默认为YES
@property (nonatomic, assign) BOOL isHeaderRefreshed;

@end

NS_ASSUME_NONNULL_END
