//
//  DJClassifyListLeftView.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "DJClassifyListLeftView.h"

#import "DJClassifyListLeftCell.h"
#import "DJO2OCategoryListModel.h"
#import "DJB2CCategoryModel.h"

@interface DJClassifyListLeftView()<UITableViewDataSource,UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray<DJClassifyBaseCategoryModel *> *dataList;
@end

@implementation DJClassifyListLeftView
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
- (void)dataFill:(NSArray<DJClassifyBaseCategoryModel *> *)catagoryList {
    self.dataList = catagoryList;
    [self.tableView reloadData];
    if(self.dataList.count > 0 && self.tableView.indexPathsForSelectedRows.count <= 0) {
        self.currentIdx = 0;
        !self.didSelectRowBlock ?: self.didSelectRowBlock(0);
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark -
#pragma mark - 👀Public Actions
- (BOOL)scrollToPreviousRow {
    return [self scrollToRowWithType: DJClassifyLeftScrollTypePrevious];
}
- (BOOL)scrollToNextRow {
    return [self scrollToRowWithType: DJClassifyLeftScrollTypeNext];
}
- (void)scrollToRowAtIndexPath:(NSIndexPath *)ip {
    if(ip.row < 0 ||
       (ip.row > self.dataList.count - 1)) {
        return;
    }
    [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (BOOL)scrollToRowWithType:(DJClassifyLeftScrollType)scrollType {
    NSIndexPath *ip;
    switch (scrollType) {
        case DJClassifyLeftScrollTypePrevious:
            ip = [NSIndexPath
                  indexPathForRow:self.tableView.indexPathForSelectedRow.row - 1
                  inSection:self.tableView.indexPathForSelectedRow.section];
            break;

        case DJClassifyLeftScrollTypeNext:
            ip = [NSIndexPath
                  indexPathForRow:self.tableView.indexPathForSelectedRow.row + 1
                  inSection:self.tableView.indexPathForSelectedRow.section];
            break;
    }
    if(ip) {
        if(ip.row <= 1) {
            return NO;
        } else if(ip.row <= self.dataList.count - 1) {
            return NO;
        }
        [self.tableView selectRowAtIndexPath:ip
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
        return YES;
    }
    return NO;
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJClassifyListLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DJClassifyListLeftCell" forIndexPath:indexPath];
    DJClassifyBaseCategoryModel *categoryModel = self.dataList[indexPath.row];
    if(self.headerType == DJNewClassifyHeaderTypeO2O) {
        DJO2OCategoryListModel *tmp = (DJO2OCategoryListModel *)categoryModel;
        [cell dataFill:categoryModel.categoryName logo:tmp.categoryIcon];
    } else {
        // DJB2CCategoryModel *tmp = (DJB2CCategoryModel *)categoryModel;
        [cell dataFill:categoryModel.categoryName logo:nil];
    }
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // DJClassifyBaseCategoryModel *baseModel = self.dataList[indexPath.row];
    self.currentIdx = indexPath.row;
    !self.didSelectRowBlock ?: self.didSelectRowBlock(indexPath.row);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.tableView registerClass:[DJClassifyListLeftCell class] forCellReuseIdentifier:@"DJClassifyListLeftCell"];
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
        t.backgroundColor = [UIColor colorWithHex:0xF9F9F9];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        t.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        t.separatorStyle = UITableViewCellSeparatorStyleNone;
        t.estimatedRowHeight = 44.0f;
        t.rowHeight = UITableViewAutomaticDimension;
        t.sectionHeaderHeight = 0.f;
        t.sectionFooterHeight = 0.f;
        t.estimatedRowHeight = 0;
        t.estimatedSectionHeaderHeight = 0;
        t.estimatedSectionFooterHeight = 0;
        t.showsVerticalScrollIndicator = NO;

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
