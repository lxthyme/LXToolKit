//
//  LXClassifyWrapperVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyWrapperVC.h"

#import "LXSectionModel.h"
#import "LXClassifyListVC.h"
#import "LXFirstCategoryView.h"

static const CGFloat kLabelAllWidth = 35.f;

@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, JXCategoryViewListContainer> {
}
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LXFirstCategoryView *categoryView;
@property (nonatomic, strong)LXFirstCategoryView *allCategoryView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)NSArray<LXCategoryModel *> *dataList;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;

@end

@implementation LXClassifyWrapperVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
    // self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
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
        RACTwoTuple *tmp1 = value.first;
        RACTwoTuple *tmp2 = tmp1.first;
        NSMutableArray *a = [NSMutableArray array];
        [a addObject:tmp2.first];
        [a addObject:tmp2.second];
        [a addObject:tmp1.second];
        [a addObject:value.second];
        return [RACFourTuple tupleWithObjectsFromArray:a];
    }]
                     map:^id _Nullable(RACFourTuple *_Nullable tuple) {
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
        if([tuple.first isEqual:@(3)]) {
            category.title = @"苹";
        }
        category.imageNames = tuple.third;
        category.selectedImageNames = tuple.fourth;
        category.imageType = JXCategoryTitleImageType_TopImage;
        category.subCategoryList = subCategoryList;
        return category;
    }].array;

    [self dataFill];
}
- (void)dataFill {
    RACSequence *imageType = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
        return @(model.imageType);
    }];
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
    // self.categoryView.titles = titles.array;
    // self.categoryView.imageNames = imageNames.array;
    // self.categoryView.selectedImageNames = selectedImageNames.array;
    ///
    // self.allCategoryView
    // self.allCategoryView.imageTypes = imageType.array;
    // self.allCategoryView.titles = titles.array;
    // self.allCategoryView.imageNames = imageNames.array;
    // self.allCategoryView.selectedImageNames = selectedImageNames.array;
    [self.categoryView dataFill:self.dataList];
    [self.allCategoryView dataFill:self.dataList];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryViewListContainer
- (void)listContainerViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    CGFloat page = floorf(offset.x / CGRectGetWidth(scrollView.frame));
    if(self.categoryView.selectedIndexPath.row != page) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:page inSection:0];
        [self.categoryView selectItemAtIndex:ip.row];
        [self.allCategoryView selectItemAtIndex:ip.row];
    }
}
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
        self.allMaskView.hidden = NO;
        POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        maskAnim.fromValue = @1.f;
        maskAnim.toValue = @0.f;
        [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.fromValue = @100.f;
        anim.toValue = @(-200.f);
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            self.allMaskView.hidden = YES;
        };
        [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];


    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.labAll];
    [self.view addSubview:self.imgViewShadowLeft];
    [self.view addSubview:self.imgViewShadowRight];
    [self.view addSubview:self.listContainerView];

    [self.allMaskView addSubview:self.allCategoryView];
    [self.view addSubview:self.allMaskView];

    [self masonry];
}
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(kFirstCategoryFoldHeight));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.imgViewShadowLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(@0.f);
    }];
    [self.imgViewShadowRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.right.equalTo(self.labAll.mas_left);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];

    [self.allMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_top);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@200.f);
    }];
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
        UIFont *font = [UIFont boldSystemFontOfSize:kWPercentage(11.f)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        [attr yy_appendString:@"全 部"];
        attr.yy_font = font;
        attr.yy_color = [UIColor colorWithHex:0x333333];
        UIImage *img = [iBLImage imageNamed:@"icon_unfold"];
        NSMutableAttributedString *attachment = [NSMutableAttributedString
                                                 yy_attachmentStringWithContent:img
                                                 contentMode:UIViewContentModeCenter
                                                 attachmentSize:img.size
                                                 alignToFont:font
                                                 alignment:YYTextVerticalAlignmentCenter];
        [attr yy_appendString:@" "];
        [attr appendAttributedString:attachment];
        lab.attributedText = attr;
        lab.verticalForm = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        lab.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectZero]];
        WEAKSELF(self)
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            weakSelf.allMaskView.hidden = NO;
            POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            maskAnim.fromValue = @0.f;
            maskAnim.toValue = @1.f;
            [weakSelf.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            anim.fromValue = @(-200.f);
            anim.toValue = @100.f;
            anim.springBounciness = 0.f;
            [weakSelf.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LXFirstCategoryView *)categoryView {
    if(!_categoryView){
        LXFirstCategoryView *v = [[LXFirstCategoryView alloc]initWithFirstCategoryType:LXFirstCategoryTypeFold];
        // v.backgroundColor = [UIColor whiteColor];
        // // v.imageZoomEnabled = YES;
        // // v.imageZoomScale = 1.3f;
        // v.titleColorGradientEnabled = NO;
        // // v.titleLabelMaskEnabled = YES;
        // v.averageCellSpacingEnabled = YES;
        // v.titleColor = [UIColor colorWithHex:0x333333];
        // v.titleSelectedColor = [UIColor whiteColor];
        // v.cellSpacing = 0.f;
        // v.cellWidth = (SCREEN_WIDTH - kLabelAllWidth) / kCategoryMaxCount;
        // v.imageSize = CGSizeMake(44.f, 44.f);
        // v.listContainer = self.listContainerView;
        // v.delegate = self;

        // JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        // lineView.indicatorWidth = 20;
        // v.indicators = @[lineView];
        // JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        // backgroundView.indicatorWidthIncrement = 0;
        // backgroundView.indicatorHeight = 20;
        // backgroundView.indicatorCornerRadius = 10;
        // backgroundView.indicatorColor = [UIColor colorWithHex:0xFF774F];
        // backgroundView.verticalMargin = -25;
        // v.indicators = @[backgroundView];

        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.allCategoryView selectItemAtIndex:idx];
                [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf.listContainerView.contentScrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.contentScrollView.bounds.size.width, 0) animated:YES];
            });
        };
        _categoryView = v;
    }
    return _categoryView;
}
- (UIImageView *)imgViewShadowLeft {
    if(!_imgViewShadowLeft){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"dj_category_shadow_left"];
        _imgViewShadowLeft = iv;
    }
    return _imgViewShadowLeft;
}
- (UIImageView *)imgViewShadowRight {
    if(!_imgViewShadowRight){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"dj_category_shadow_right"];
        _imgViewShadowRight = iv;
    }
    return _imgViewShadowRight;
}


- (LXFirstCategoryView *)allCategoryView {
    if(!_allCategoryView){
        LXFirstCategoryView *v = [[LXFirstCategoryView alloc]initWithFirstCategoryType:LXFirstCategoryTypeUnfold];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.categoryView selectItemAtIndex:idx];
                [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf.listContainerView.contentScrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.contentScrollView.bounds.size.width, 0) animated:YES];
            });
        };
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
