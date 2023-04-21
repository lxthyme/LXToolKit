//
//  LXNestedListView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNestedListView : UIView<JXCategoryListContentViewDelegate> {
}
@property (nonatomic, copy)void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray<NSString *> *dataSource;

@end

NS_ASSUME_NONNULL_END
