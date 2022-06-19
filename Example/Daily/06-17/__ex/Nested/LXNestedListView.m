//
//  LXNestedListView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNestedListView.h"

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

@interface LXNestedListView()<UITableViewDataSource,UITableViewDelegate> {
}

@end

@implementation LXNestedListView
- (void)dealloc {
    // self.scrollCallback = nil;
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTableView];
        [self prepareUI];
    }
    return self;
}
// - (void)layoutSubviews {
//     [super layoutSubviews];
// 
//     self.tableView.frame = self.bounds;
// }

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.tableView;
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate {
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // self.tableView.frame = CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50);
    WEAKSELF(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataSource addObject:@"加载更多成功"];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.tableView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(@0.f);
    // }];
}

#pragma mark Lazy Property
- (UITableView *)tableView {
    if(!_tableView){
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableFooterView = [UIView new];
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.estimatedRowHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }

        [t setDelegate:self];
        [t setDataSource:self];

        [t setBackgroundColor:[UIColor whiteColor]];

        [t setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
        [t setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [t setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        _tableView = t;
    }
    return _tableView;
}
@end
