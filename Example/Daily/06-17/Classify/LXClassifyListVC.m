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
#import "LXClassifyListRightView.h"

static const CGFloat kLeftTableWidth = 100.f;

@interface LXClassifyListVC()<JXCategoryViewDelegate> {
}
@property(nonatomic, strong)LXClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)LXClassifyListRightView *panelRightView;
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
}
#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXCategoryModel *)cateogryModel {
    [self.panelLeftView dataFill:cateogryModel.sectionList];
    [self.panelRightView dataFill:cateogryModel.sectionList];
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
#pragma mark - ✈️JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.panelRightView.collectionView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.panelLeftView];
    [self.view addSubview:self.panelRightView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.panelLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
    }];
    [self.panelRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0.f);
        make.left.equalTo(self.panelLeftView.mas_right);
    }];
}
#pragma mark getter/setter
#pragma mark Lazy Property
- (LXClassifyListRightView *)panelRightView {
    if(!_panelRightView){
        LXClassifyListRightView *v = [[LXClassifyListRightView alloc]init];
        _panelRightView = v;
    }
    return _panelRightView;
}
- (LXClassifyListLeftView *)panelLeftView {
    if(!_panelLeftView){
        LXClassifyListLeftView *v = [[LXClassifyListLeftView alloc]init];
        _panelLeftView = v;
    }
    return _panelLeftView;
}
@end
