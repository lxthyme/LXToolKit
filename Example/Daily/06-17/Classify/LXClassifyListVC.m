//
//  LXClassifyListVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListVC.h"

#import "LXSectionModel.h"
#import "LXClassifyListLeftView.h"
#import "LXClassifyListPanelRightView.h"

static const CGFloat kLeftTableWidth = 100.f;

@interface LXClassifyListVC()<JXCategoryViewDelegate> {
}
@property(nonatomic, strong)UIView *topPanelView;
@property(nonatomic, strong)LXClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)LXClassifyListPanelRightView *rightPanelView;
@property(nonatomic, copy)NSArray<LXSectionModel *> *dataList;

@end

@implementation LXClassifyListVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
    [self loadData];
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)loadData {
    NSMutableArray *dataList = [NSMutableArray array];
    /// section 0: banner
    [dataList addObject:@[]];
    NSArray *imageNames = @[@"boat", @"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon", @"watermelon"];
    NSArray<NSString *> *titleList = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事", @"lastOne"];
    [titleList enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        LXSectionModel *sectionModel = [[LXSectionModel alloc] init];
        sectionModel.sectionTitle = title;
        NSUInteger randomCount = arc4random()%10 + 5;
        NSMutableArray *itemList = [NSMutableArray array];
        if(idx == titleList.count - 1) {
            randomCount = 1;
        }
        for (int i = 0; i < randomCount; i ++) {
            LXSectionItemModel *itemModel = [[LXSectionItemModel alloc] init];
            itemModel.icon = imageNames[idx];
            itemModel.title = title;
            [itemList addObject:itemModel];
        }
        sectionModel.itemList = itemList;
        [dataList addObject:sectionModel];
    }];
    [self.rightPanelView dataFill:self.dataList];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    
    [self.view addSubview:self.topPanelView];

    [self.view addSubview:self.panelLeftView];
    [self.view addSubview:self.rightPanelView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.panelLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
    }];
    [self.rightPanelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0.f);
        make.left.equalTo(self.panelLeftView.mas_right);
    }];
}
#pragma mark getter/setter
#pragma mark Lazy Property
- (UIView *)topPanelView {
    if(!_topPanelView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _topPanelView = v;
    }
    return _topPanelView;
}
- (LXClassifyListPanelRightView *)rightPanelView {
    if(!_rightPanelView){
        LXClassifyListPanelRightView *v = [[LXClassifyListPanelRightView alloc]init];
        _rightPanelView = v;
    }
    return _rightPanelView;
}
- (LXClassifyListLeftView *)panelLeftView {
    if(!_panelLeftView){
        LXClassifyListLeftView *v = [[LXClassifyListLeftView alloc]init];
        _panelLeftView = v;
    }
    return _panelLeftView;
}
@end
