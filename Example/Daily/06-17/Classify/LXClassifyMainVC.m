//
//  LXClassifyMainVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyMainVC.h"

#import "LXClassifyListVC.h"

static CGFloat kCategoryViewHeight = 60.f;

@interface LXClassifyMainVC()<JXCategoryViewDelegate> {
}
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;

@end

@implementation LXClassifyMainVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
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
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXClassifyListVC *vc = [[LXClassifyListVC alloc]init];
    return vc;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    self.titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];
    NSMutableArray *imageTypes = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        [imageTypes addObject:@(JXCategoryTitleImageType_TopImage)];
    }
    self.categoryView.imageTypes = imageTypes;
    self.categoryView.listContainer = self.listContainerView;
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@(kCategoryViewHeight));
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleImageView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleImageView *v = [[JXCategoryTitleImageView alloc]init];
        v.imageZoomEnabled = YES;
        v.imageZoomScale = 1.3f;
        v.averageCellSpacingEnabled = NO;
        v.delegate = self;

        NSArray *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
        NSArray *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];
        v.titles = self.titles;
        v.imageNames = imageNames;
        v.selectedImageNames = selectedImageNames;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
@end
