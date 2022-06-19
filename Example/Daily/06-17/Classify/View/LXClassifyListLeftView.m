//
//  LXClassifyListLeftView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListLeftView.h"

#import "LXLeftCell.h"

@interface LXClassifyListLeftView()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *leftTableView;
@property(nonatomic, copy)NSArray<NSString *> *leftDataList;

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
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftDataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXLeftCell" forIndexPath:indexPath];
    NSString *title = self.leftDataList[indexPath.row];
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
    [self.leftTableView registerClass:[LXLeftCell class] forCellReuseIdentifier:@"LXLeftCell"];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.leftTableView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSArray<NSString *> *)leftDataList {
    if(!_leftDataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld", i]];
        }
        _leftDataList = [arr copy];
    }
    return _leftDataList;
}
- (UITableView *)leftTableView {
    if(!_leftTableView) {
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
        _leftTableView = t;
    }
    return _leftTableView;
}
@end
