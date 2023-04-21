//
//  LXClassifyList2VC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/29.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyList2VC.h"

#import "LXClassifyListVC.h"
#import "LXSectionModel.h"

@interface LXClassifyList2VC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) UIScrollView *currentListView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)NSArray<LXCategoryModel *> *dataList;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;

@end

@implementation LXClassifyList2VC
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
    NSArray *titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];
    NSArray<NSString *> *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    NSArray<NSString *> *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];
    // [[RACThreeTuple pack:titles :imageNames :selectedImageNames].rac_sequence
    // [[RACThreeTuple tupleWithObjectsFromArray:@[titles, imageNames, selectedImageNames]].rac_sequence
    self.dataList = [[[[[@[@1, @2, @3, @4, @5, @6].rac_sequence zipWith:titles.rac_sequence]
                        zipWith:imageNames.rac_sequence]
                       zipWith:selectedImageNames.rac_sequence]
                      map:^id _Nullable(RACTuple * _Nullable value) {
        RACTuple *tmp1 = value.first;
        RACTuple *tmp2 = tmp1.first;
        NSMutableArray *a = [NSMutableArray array];
        [a addObject:tmp2.first];
        [a addObject:tmp2.second];
        [a addObject:tmp1.second];
        [a addObject:value.second];
        return [RACTuple tupleWithObjectsFromArray:a];
    }]
                     map:^id _Nullable(RACTuple *_Nullable tuple) {
        NSMutableArray *subCategoryList = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; j++) {
            NSMutableArray *sectionList = [NSMutableArray array];
            /// section 0: banner
            // [dataList addObject:@[]];
            NSArray *imageNames = @[@"boat", @"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon", @"watermelon"];
            NSArray<NSString *> *titleList = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事", @"lastOne"];
            [titleList enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger randomCount = arc4random()%10 + 5;
                NSMutableArray *itemList = [NSMutableArray array];
                if(idx == titleList.count - 1) {
                    randomCount = 1;
                }
                for (NSInteger i = 0; i < randomCount; i ++) {
                    LXSectionItemModel *itemModel = [[LXSectionItemModel alloc] init];
                    itemModel.icon = imageNames[idx];
                    itemModel.title = [NSString stringWithFormat:@"[%@,%ld,%ld,%ld]%@", tuple.first, j, idx, i, title];
                    [itemList addObject:itemModel];
                }
                LXSectionModel *sectionModel = [[LXSectionModel alloc] init];
                sectionModel.title = [NSString stringWithFormat:@"[%@,%ld,%ld]%@", tuple.first, j, idx, title];
                sectionModel.itemList = itemList;
                [sectionList addObject:sectionModel];
            }];
            LXSubCategoryModel *subCategory = [[LXSubCategoryModel alloc]init];
            LXSubCategoryIndexType idxType = LXSubCategoryIndexTypeDefault;
            if(j == 0) {
                idxType = LXSubCategoryIndexTypeFirst;
            } else if(j == 19) {
                idxType = LXSubCategoryIndexTypeLast;
            }
            subCategory.idxType = idxType;
            subCategory.title = [NSString stringWithFormat:@"[%@]row: %ld", tuple.first, j];
            subCategory.sectionList = sectionList;
            [subCategoryList addObject:subCategory];
        }
        LXCategoryModel *category = [[LXCategoryModel alloc]init];
        // category.title = [NSString stringWithFormat:@"row: %ld", j];
        category.title = [NSString stringWithFormat:@"[%@]%@", tuple.first, tuple.second];
        category.imageNames = tuple.third;
        category.selectedImageNames = tuple.fourth;
        // category.imageType = JXCategoryTitleImageType_TopImage;
        category.subCategoryList = subCategoryList;
        return category;
    }].array;

    [self dataFill];
}
- (void)dataFill {
// RACSequence *imageType = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
//     return @(model.imageType);
// }];
RACSequence *titles = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
    return model.title;
}];
RACSequence *imageNames = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
    return model.imageNames;
}];
RACSequence *selectedImageNames = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
    return model.selectedImageNames;
}];
// self.categoryView.imageTypes = [imageType take:kCategoryMaxCount].array;
// self.categoryView.titles = [titles take:kCategoryMaxCount].array;
// self.categoryView.imageNames = [imageNames take:kCategoryMaxCount].array;
// self.categoryView.selectedImageNames = [selectedImageNames take:kCategoryMaxCount].array;
///
// self.categoryView.imageTypes = imageType.array;
self.categoryView.titles = titles.array;
// self.categoryView.imageNames = imageNames.array;
// self.categoryView.selectedImageNames = selectedImageNames.array;
///
// self.allCategoryView
// self.allCategoryView.imageTypes = imageType.array;
// self.allCategoryView.titles = titles.array;
// self.allCategoryView.imageNames = imageNames.array;
// self.allCategoryView.selectedImageNames = selectedImageNames.array;
    [self.categoryView reloadData];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPagerViewListViewDelegate
- (UIView *)listView {
    return self.view;
}
- (UIScrollView *)listScrollView {
    return self.currentListView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (void)listScrollViewWillResetContentOffset {
    //当前的listScrollView需要重置的时候，就把所有列表的contentOffset都重置了
    // for (TestNestListBaseView *list in self.listContainerView.validListDict.allValues) {
    //     list.tableView.contentOffset = CGPointZero;
    // }
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //根据选中的下标，实时更新currentListView
    // TestNestListBaseView *list = (TestNestListBaseView *)self.listContainerView.validListDict[@(index)];
    // self.currentListView = list.tableView;
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.dataList.count;
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
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.contentScrollView = self.listContainerView.scrollView;
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, LXClassifyListVC *> *)classifyVCList {
    if(!_classifyVCList){
        _classifyVCList = [NSMutableDictionary dictionary];
    }
    return _classifyVCList;
}
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.titleColorGradientEnabled = YES;
        v.backgroundColor = [UIColor cyanColor];
        v.delegate = self;
        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        // TODO: 「lxthyme」💊
        // [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
@end
