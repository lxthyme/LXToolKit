//
//  LXClassifyListLeftView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListLeftView.h"

#import "LXClassifyListLeftCell.h"

@interface LXClassifyListLeftView()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray<NSString *> *dataList;
@end

@implementation LXClassifyListLeftView
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

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(NSArray<NSString *> *)dataList {
    self.dataList = dataList;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXClassifyListLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXClassifyListLeftCell" forIndexPath:indexPath];
    NSString *title = self.dataList[indexPath.row];
    [cell dataFill:title];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[LXClassifyListLeftCell class] forCellReuseIdentifier:@"LXClassifyListLeftCell"];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.tableView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        t.backgroundColor = [UIColor lightGrayColor];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        t.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;

        t.delegate = self;
        t.dataSource = self;

        if (@available(iOS 11.0, *)) {
            t.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if(@available(iOS 13.0, *)) {
            t.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        if(@available(iOS 15.0, *)) {
            t.sectionHeaderTopPadding = 0.f;
        }
        _tableView = t;
    }
    return _tableView;
}
@end
