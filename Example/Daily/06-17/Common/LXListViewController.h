//
//  LXListViewController.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXPagingView/JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXListViewController : UIViewController<JXPagerViewListViewDelegate> {
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray<NSString *> *dataSource;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
/// 默认为YES
@property (nonatomic, assign) BOOL isHeaderRefreshed;

- (void)viewWillAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewWillDisappear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidDisappear:(BOOL)animated NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
