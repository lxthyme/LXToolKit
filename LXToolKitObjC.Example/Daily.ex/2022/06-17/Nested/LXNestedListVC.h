//
//  LXNestedListVC.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXPagingView/JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNestedListVC : UIViewController<JXPagerViewListViewDelegate> {
}
@property(nonatomic, strong)UIScrollView *contentScrollView;

@end

NS_ASSUME_NONNULL_END
