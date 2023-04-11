//
//  DJViewController.m
//  DJObjcModule
//
//  Created by lxthyme on 03/31/2023.
//  Copyright (c) 2023 lxthyme. All rights reserved.
//

#import "DJViewController.h"

#import <Masonry/Masonry.h>

#import "DJSwiftModule-Swift.h"
#import "DJObjcModule-Swift.h"
#import "DJBusinessModuleSwift-Swift.h"
#import <DJObjcModule/DJObjCVC.h>

@interface DJViewController ()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSString *> *dataList;

@end

@implementation DJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self prepareUI];
    [self prepareTableView];
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        Application *app = [Application shared];
        app.previousRootVC = window.rootViewController;
        [app presentInitialScreenIn:window];
    } else if(indexPath.row == 1) {
        LXTestVC *vc = [[LXTestVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 2) {
        DJObjCVC *vc = [[DJObjCVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareTableView {
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.table];
    [self masonry];
}
#pragma mark getter / setter
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(@0.f);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark Lazy Property
- (NSArray<NSString *> *)dataList {
    if(!_dataList){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"row: %ld", i]];
        }
        _dataList = [arr copy];
    }
    return _dataList;
}
- (UITableView *)table {
    if(!_table) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        // t.backgroundColor = [UIColor whiteColor];
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
        _table = t;
    }
    return _table;
}
@end
