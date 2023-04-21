//
//  LXPageListView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPageListView/JXPageListView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPageListView : UIView<JXPageListViewListDelegate> {
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSource;
@property (nonatomic, assign) BOOL isNeedHeader;
@property (nonatomic, assign) BOOL isFirstLoaded;

@end

NS_ASSUME_NONNULL_END
