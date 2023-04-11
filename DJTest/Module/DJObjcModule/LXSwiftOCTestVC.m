//
//  LXSwiftOCTestVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2023/4/10.
//  Copyright © 2023 lxthyme. All rights reserved.
//
#import "LXSwiftOCTestVC.h"

#import <Masonry/Masonry.h>

#import <LXToolKitObjc/LXToolKitObjc.h>
#import <LXToolKit-Swift.h>
#import "DJSwiftModule-Swift.h"
#import "DJObjcModule-Swift.h"
#import "DJBusinessModuleSwift-Swift.h"
#import <DJObjcModule/DJObjCVC.h>

typedef NS_ENUM(NSInteger, DJCellType) {
    DJCellTypeLXToolKit,
    DJCellTypeLXToolKitObjc,
    DJCellTypeDJSwiftModule,
    DJCellTypeDJBusinessModuleSwift,
    DJCellTypeDJObjcModule,
};

@interface LXSwiftOCTestVC()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSNumber *> *dataList;

@end

@implementation LXSwiftOCTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self prepareTableView];

    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.dataList = [@[
        @(DJCellTypeLXToolKit),
        @(DJCellTypeLXToolKitObjc),
        @(DJCellTypeDJSwiftModule),
        @(DJCellTypeDJBusinessModuleSwift),
        @(DJCellTypeDJObjcModule),
    ] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] > [obj2 integerValue];
    }];
    [self.table reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *title = [self.dataList[indexPath.row] stringValue];
    switch ([self.dataList[indexPath.row] integerValue]) {
        case DJCellTypeLXToolKit:
            title = @"LXToolKit";
            break;
        case DJCellTypeLXToolKitObjc:
            title = @"LXToolKitObjc";
            break;
        case DJCellTypeDJObjcModule:
            title = @"DJObjcModule";
            break;
        case DJCellTypeDJSwiftModule:
            title = @"DJSwiftModule";
            break;
        case DJCellTypeDJBusinessModuleSwift:
            title = @"DJBusinessModuleSwift";
            break;
    }
    cell.textLabel.text = title;
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DJCellType cellType = [self.dataList[indexPath.row] integerValue];
    switch ([self.dataList[indexPath.row] integerValue]) {
        case DJCellTypeLXToolKit: {
        } break;
        case DJCellTypeLXToolKitObjc:{
        } break;
        case DJCellTypeDJObjcModule:{
            DJObjCVC *vc = [[DJObjCVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case DJCellTypeDJSwiftModule:{
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            Application *app = [Application shared];
            app.previousRootVC = window.rootViewController;
            [app presentInitialScreenIn:window];
        } break;
        case DJCellTypeDJBusinessModuleSwift:{
            LXTestVC *vc = [[LXTestVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
    }
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareTableView {
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.table];
    [self masonry];
}

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
