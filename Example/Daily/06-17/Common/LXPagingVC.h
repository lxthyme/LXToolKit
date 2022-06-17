//
//  LXPagingVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "LXHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;

@interface LXPagingVC : UIViewController<JXPagerMainTableViewGestureDelegate, JXPagerViewDelegate> {
}
@property (nonatomic, strong)JXPagerView *pagerView;
@property (nonatomic, strong)LXHeaderView *headerView;
@property (nonatomic, strong, readonly)JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;

- (void)viewWillAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidAppear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewWillDisappear:(BOOL)animated __attribute__((objc_requires_super));
- (void)viewDidDisappear:(BOOL)animated NS_REQUIRES_SUPER;

- (JXPagerView *)preferredPagingView;

- (void)prepareUI;
- (void)masonry;
@end

NS_ASSUME_NONNULL_END
