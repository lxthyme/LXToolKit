//
//  ViewController.m
//  DJTest
//
//  Created by lxthyme on 2023/3/31.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <DJObjcModule/DJObjCVC.h>
#import "LXToolKit_Example-Swift.h"
#import "DJRSwiftTest-Swift.h"
#import "DJBusinessModuleSwift-Swift.h"
#import "DJSwiftModule-Swift.h"
#import <LXToolKitObjC_Example/LXToolKitObjCTestVC.h>

typedef NS_ENUM(NSInteger, DJCellType) {
    DJCellTypeLXToolKit,
    DJCellTypeLXToolObjCKit,
    DJCellTypeDJObjcModule,
    DJCellTypeDJSwiftModule,
    DJCellTypeDJBusinessModuleSwift,
    DJCellTypeDJRSwiftTest,
};

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, strong)UITableView *table;
@property(nonatomic, copy)NSArray<NSNumber *> *dataList;
@end

@implementation ViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // LXSwiftOCTestVC *vc = [[LXSwiftOCTestVC alloc]init];
    // [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self prepareTableView];

    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill {
    self.dataList = @[
        @(DJCellTypeLXToolKit),
        @(DJCellTypeLXToolObjCKit),
        @(DJCellTypeDJObjcModule),
        @(DJCellTypeDJSwiftModule),
        @(DJCellTypeDJBusinessModuleSwift),
        @(DJCellTypeDJRSwiftTest),
    ];
    [self.table reloadData];
}

#pragma mark - ✈️UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *title = [self.dataList[indexPath.row] stringValue];
    switch ([self.dataList[indexPath.row] integerValue]) {
        case DJCellTypeLXToolKit: {
            title = @"LXToolKit";
        } break;
        case DJCellTypeLXToolObjCKit: {
            title = @"LXToolObjCKit";
        } break;
        case DJCellTypeDJObjcModule: {
            title = @"DJObjcModule";
        } break;
        case DJCellTypeDJSwiftModule: {
            title = @"DJSwiftModule";
        } break;
        case DJCellTypeDJBusinessModuleSwift: {
            title = @"DJBusinessModuleSwift";
        } break;
        case DJCellTypeDJRSwiftTest: {
            title = @"DJRSwiftTest";
        } break;
    }
    cell.textLabel.text = title;
    return cell;
}
#pragma mark - ✈️UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    switch ([self.dataList[indexPath.row] integerValue]) {
        case DJCellTypeLXToolKit: {
            vc = [[LXToolKitTestVC alloc]init];
        } break;
        case DJCellTypeLXToolObjCKit: {
            vc = [[LXToolKitObjCTestVC alloc]init];
        } break;
        case DJCellTypeDJObjcModule: {
            vc = [[DJObjCVC alloc]init];
        } break;
        case DJCellTypeDJSwiftModule: {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            Application *app = [Application shared];
            app.previousRootVC = window.rootViewController;
            [app presentInitialScreenIn:window];
        } break;
        case DJCellTypeDJBusinessModuleSwift: {
            vc = [[DJBusinessModuleSwiftVC alloc]init];
        } break;
        case DJCellTypeDJRSwiftTest: {
            vc = [[DJRSwiftTestVC alloc]init];
        } break;
    }
    if(vc) {
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
- (UITableView *)table {
    if(!_table) {
        UITableView *t = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        t.tableHeaderView = [UIView new];
        t.tableFooterView = [UIView new];
        // t.backgroundColor = [UIColor <#whiteColor#>];
        t.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        // t.indicatorStyle = <#UIScrollViewIndicatorStyl#>;
        // t.separatorStyle = <#UITableViewCellSeparatorStyl#>;
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
