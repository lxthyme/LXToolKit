//
//  LXClassifyWrapperVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyWrapperVC.h"

#import "LXClassifyListVC.h"
#import <YYText/YYLabel.h>

static const CGFloat kLabelAllWidth = 44.f;
static const CGFloat kCategoryHeight = 80.f;
static const NSInteger kCategoryMaxCount = 5;

@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
}
@property (nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong)JXCategoryTitleImageView *allCategoryView;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)NSArray<LXCategoryModel *> *dataList;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;

@end

@implementation LXClassifyWrapperVC
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

    [self prepareVM];
    [self prepareUI];
    [self loadData];
    [self dataFill];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)loadData {
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger j = 0; j < 20; j++) {
        NSMutableArray *sectionList = [NSMutableArray array];
        /// section 0: banner
        // [dataList addObject:@[]];
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
            [sectionList addObject:sectionModel];
        }];
        LXCategoryModel *category = [[LXCategoryModel alloc]init];
        category.categoryTitle = [NSString stringWithFormat:@"row: %ld", j];
        category.sectionList = sectionList;
        [dataList addObject:category];
    }
    self.dataList = [dataList copy];
    // [self.tableView reloadData];
    // [self.collectionView reloadData];
}
- (void)dataFill {
    self.titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];

    // NSArray<NSDictionary *> *imageList = @[
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    //     @{ @"imageName": @"", @"selectedImageName": @"" },
    // ];
    NSArray<NSString *> *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    NSArray<NSString *> *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];
    RACSequence<NSNumber *> *imageTypes = [self.titles.rac_sequence
                                  map:^id _Nullable(id  _Nullable value) {
        return @(JXCategoryTitleImageType_TopImage);
    }];
    self.categoryView.imageTypes = [imageTypes take:kCategoryMaxCount].array;
    self.categoryView.titles = [self.titles.rac_sequence take:kCategoryMaxCount].array;
    self.categoryView.imageNames = [imageNames.rac_sequence take:kCategoryMaxCount].array;
    self.categoryView.selectedImageNames = [selectedImageNames.rac_sequence take:kCategoryMaxCount].array;

    self.allCategoryView.imageTypes = imageTypes.array;
    self.allCategoryView.titles = self.titles;
    self.allCategoryView.imageNames = imageNames;
    self.allCategoryView.selectedImageNames = selectedImageNames;
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
    LXClassifyListVC *vc = self.classifyVCList[@(index)];
    if(!vc) {
        vc = [[LXClassifyListVC alloc]init];
        self.classifyVCList[@(index)] = vc;
    }
    LXCategoryModel *categoryModel = self.dataList[index];
    [vc dataFill:categoryModel];
    return vc;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    // [[[self.labAll rac_signalForControlEvents:UIControlEventTouchUpInside]
    // takeUntil:self.rac_willDeallocSignal]
    //  subscribeNext:^(__kindof UIControl * _Nullable x) {
    //     NSLog(@"btn: %@", x);
    // }];
    @weakify(self)
    [[self.allMaskView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.allMaskView.opaque = 1.f;
        self.allCategoryView.opaque = 1.f;
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.allMaskView.opaque = 0.f;
            CGRect frame = self.allCategoryView.frame;
            frame.origin.y -= CGRectGetHeight(self.allCategoryView.frame) + 20.f;
            self.allCategoryView.frame = frame;
            self.allMaskView.opaque = 0.f;
            self.allCategoryView.opaque = 0.f;
        } completion:^(BOOL finished) {
            self.allMaskView.hidden = YES;
        }];
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.labAll];
    [self.view addSubview:self.listContainerView];

    // [self.allMaskView addSubview:self.allCategoryView];
    // [self.view addSubview:self.allMaskView];

    [self masonry];
}
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(kCategoryHeight));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];

    // [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(self.categoryView.mas_bottom);
    //     make.left.right.bottom.equalTo(@0.f);
    // }];
    // [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.left.right.equalTo(@0.f);
    //     make.height.equalTo(@200.f);
    // }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, LXClassifyListVC *> *)classifyVCList {
    if(!_classifyVCList){
        _classifyVCList = [NSMutableDictionary dictionary];
    }
    return _classifyVCList;
}
- (YYLabel *)labAll {
    if(!_labAll){
        YYLabel *lab = [[YYLabel alloc]init];
        lab.text = @"全部";
        lab.textColor = [UIColor blackColor];
        lab.verticalForm = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        lab.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectZero]];
        WEAKSELF(self)
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            self.allMaskView.opaque = 0.f;
            self.allMaskView.hidden = NO;
            self.allCategoryView.opaque = 0.f;
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect frame = self.allCategoryView.frame;
                frame.origin.y = CGRectGetMaxY(weakSelf.categoryView.frame);
                weakSelf.allCategoryView.frame = frame;
                weakSelf.allMaskView.opaque = 1.f;
                self.allCategoryView.opaque = 1.f;
            } completion:nil];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (JXCategoryTitleImageView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleImageView *v = [[JXCategoryTitleImageView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.imageZoomEnabled = YES;
        v.imageZoomScale = 1.3f;
        v.averageCellSpacingEnabled = YES;
        v.cellSpacing = 0.f;
        v.cellWidth = (SCREEN_WIDTH - kLabelAllWidth) / kCategoryMaxCount;
        v.imageSize = CGSizeMake(44.f, 44.f);
        v.listContainer = self.listContainerView;
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        v.indicators = @[lineView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryTitleImageView *)allCategoryView {
    if(!_allCategoryView){
        JXCategoryTitleImageView *v = [[JXCategoryTitleImageView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.imageZoomEnabled = YES;
        v.imageZoomScale = 1.3f;
        v.averageCellSpacingEnabled = YES;
        v.cellSpacing = 0.f;
        v.cellWidth = (SCREEN_WIDTH - kLabelAllWidth) / kCategoryMaxCount;
        v.imageSize = CGSizeMake(44.f, 44.f);
        v.delegate = self;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        v.indicators = @[lineView];

        if([v.collectionView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)v.collectionView;
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            [layout prepareLayout];
        }

        _allCategoryView = v;
    }
    return _allCategoryView;
}
- (UIControl *)allMaskView {
    if(!_allMaskView){
        UIControl *v = [[UIControl alloc]init];
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        v.hidden = YES;
        _allMaskView = v;
    }
    return _allMaskView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
@end
