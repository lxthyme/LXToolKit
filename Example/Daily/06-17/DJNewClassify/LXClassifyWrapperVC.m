//
//  LXClassifyWrapperVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyWrapperVC.h"

#import <YYText/YYText.h>
#import <YYModel/YYModel.h>
#import <JXCategoryView/JXCategoryView.h>
#import <pop/POP.h>

#import "DJGoodsItemModel.h"
#import "LXClassifyListVC.h"
#import "LXFirstCategoryFoldView.h"
#import "LXFirstCategoryUnfoldView.h"

static const CGFloat kLabelAllWidth = 35.f;

// TODO: 「lxthyme」💊
@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate/**, JXCategoryViewListContainer*/> {
}
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)LXFirstCategoryFoldView *categoryView;
@property (nonatomic, strong)LXFirstCategoryUnfoldView *allCategoryView;
@property(nonatomic, strong)UIImageView *imgViewShadowLeft;
@property(nonatomic, strong)UIImageView *imgViewShadowRight;
@property (nonatomic, strong)UIControl *allMaskView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic, strong)NSArray<LXLHCategoryModel *> *dataList;
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
    // [self loadData];
}
// - (void)updateViewConstraints {
//     [super updateViewConstraints];
//     [self masonry];
// }
#pragma mark -
#pragma mark - 🌎LoadData
// - (void)loadData {
//     NSArray *titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];
//     NSArray<NSString *> *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
//     NSArray<NSString *> *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];
//     NSMutableArray *subtitleList = [NSMutableArray array];
//     for (NSInteger i = 0; i < 5; i++) {
//         [subtitleList addObject:@"【稀缺品种】爆汁轻食伊丽莎白红口感番茄2"];
//     }
//     NSArray<DJGoodsItemModel *> *goodsList = [NSArray yy_modelArrayWithClass:[DJGoodsItemModel class] json:[self mockGoodsList]];
//     // [[RACThreeTuple pack:titles :imageNames :selectedImageNames].rac_sequence
//     // [[RACThreeTuple tupleWithObjectsFromArray:@[titles, imageNames, selectedImageNames]].rac_sequence
//     self.dataList = [[[[[@[@1, @2, @3, @4, @5, @6].rac_sequence zipWith:titles.rac_sequence]
//                         zipWith:imageNames.rac_sequence]
//                        zipWith:selectedImageNames.rac_sequence]
//                       map:^id _Nullable(RACTuple * _Nullable value) {
//         RACTuple *tmp1 = value.first;
//         RACTuple *tmp2 = tmp1.first;
//         NSMutableArray *a = [NSMutableArray array];
//         [a addObject:tmp2.first];
//         [a addObject:tmp2.second];
//         [a addObject:tmp1.second];
//         [a addObject:value.second];
//         return [RACTuple tupleWithObjectsFromArray:a];
//     }]
//                      map:^id _Nullable(RACTuple *_Nullable tuple) {
//         NSMutableArray *subCategoryList = [NSMutableArray array];
//         for (NSInteger j = 0; j < 20; j++) {
//             NSMutableArray *sectionList = [NSMutableArray array];
//             /// section 0: banner
//             // [dataList addObject:@[]];
//             NSArray *imageNames = @[@"boat", @"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon", @"watermelon"];
//             NSArray<NSString *> *titleList = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事", @"lastOne"];
//             [titleList enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
//                 NSUInteger randomCount = arc4random()%10 + 5;
//                 NSMutableArray *itemList = [NSMutableArray array];
//                 if(idx == titleList.count - 1) {
//                     randomCount = 1;
//                 }
//                 for (NSInteger i = 0; i < randomCount; i ++) {
//                     LXSectionItemModel *itemModel = [[LXSectionItemModel alloc] init];
//                     itemModel.icon = imageNames[idx];
//                     itemModel.title = [NSString stringWithFormat:@"[%@,%ld,%ld,%ld]%@", tuple.first, j, idx, i, title];
//                     itemModel.subtitle = [[subtitleList subarrayWithRange:NSMakeRange(0, i % 3 + 2)] componentsJoinedByString:@""];
//                     itemModel.num = i % 3 * 30;
//                     itemModel.goodsItem = goodsList[i % goodsList.count];
//                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                         [itemModel didFinishTransformFromDictionary];
//                     });
//                     if(i == 2) {
//                         itemModel.num = 1;
//                     }
//                     [itemList addObject:itemModel];
//                 }
//                 LXSectionModel *sectionModel = [[LXSectionModel alloc] init];
//                 sectionModel.title = [NSString stringWithFormat:@"[%@,%ld,%ld]%@", tuple.first, j, idx, title];
//                 sectionModel.itemList = itemList;
//                 [sectionList addObject:sectionModel];
//             }];
//             LXSubCategoryModel *subCategory = [[LXSubCategoryModel alloc]init];
//             LXSubCategoryIndexType idxType = LXSubCategoryIndexTypeDefault;
//             if(j == 0) {
//                 idxType = LXSubCategoryIndexTypeFirst;
//             } else if(j == 19) {
//                 idxType = LXSubCategoryIndexTypeLast;
//             }
//             subCategory.idxType = idxType;
//             subCategory.title = [NSString stringWithFormat:@"[%@]row: %ld", tuple.first, j];
//             subCategory.sectionList = sectionList;
//             [subCategoryList addObject:subCategory];
//         }
//         LXCategoryModel *category = [[LXCategoryModel alloc]init];
//         // category.title = [NSString stringWithFormat:@"row: %ld", j];
//         category.title = [NSString stringWithFormat:@"[%@]%@", tuple.first, tuple.second];
//         if([tuple.first isEqual:@(3)]) {
//             category.title = @"苹";
//         }
//         category.imageNames = tuple.third;
//         category.selectedImageNames = tuple.fourth;
//         // category.imageType = JXCategoryTitleImageType_TopImage;
//         category.subCategoryList = subCategoryList;
//         return category;
//     }].array;
//
//     [self dataFill];
// }
// - (void)dataFill {
//     // RACSequence *imageType = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
//     //     return @(model.imageType);
//     // }];
//     RACSequence *titles = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
//         return model.title;
//     }];
//     RACSequence *imageNames = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
//         return model.imageNames;
//     }];
//     RACSequence *selectedImageNames = [self.dataList.rac_sequence map:^id _Nullable(LXCategoryModel * _Nullable model) {
//         return model.selectedImageNames;
//     }];
//     // self.categoryView.imageTypes = [imageType take:kCategoryMaxCount].array;
//     // self.categoryView.titles = [titles take:kCategoryMaxCount].array;
//     // self.categoryView.imageNames = [imageNames take:kCategoryMaxCount].array;
//     // self.categoryView.selectedImageNames = [selectedImageNames take:kCategoryMaxCount].array;
//     ///
//     // self.categoryView.imageTypes = imageType.array;
//     // self.categoryView.titles = titles.array;
//     // self.categoryView.imageNames = imageNames.array;
//     // self.categoryView.selectedImageNames = selectedImageNames.array;
//     ///
//     // self.allCategoryView
//     // self.allCategoryView.imageTypes = imageType.array;
//     // self.allCategoryView.titles = titles.array;
//     // self.allCategoryView.imageNames = imageNames.array;
//     // self.allCategoryView.selectedImageNames = selectedImageNames.array;
//     [self.categoryView dataFill:self.dataList];
//     [self.allCategoryView dataFill:self.dataList];
// }

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)showFirstCategoryView {
    if(!self.allMaskView.hidden) {
        [self dismissFirstCategoryView];
        return;
    }
    self.allMaskView.hidden = NO;
    POPSpringAnimation *maskAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    maskAnim.fromValue = @0.f;
    maskAnim.toValue = @1.f;
    [self.allMaskView.layer pop_addAnimation:maskAnim forKey:@"allMaskView.opacity"];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(-200.f);
    anim.toValue = @100.f;
    anim.springBounciness = 0.f;
    [self.allCategoryView.layer pop_addAnimation:anim forKey:@"allCategoryView.translation.y"];
}
- (void)dismissFirstCategoryView {
    if(self.allMaskView.hidden) {
        return;
    }
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
}

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
- (void)listDidDisappear {
    /// 容器在隐藏时, 隐藏各种弹窗
    [self dismissFirstCategoryView];
    NSInteger idx = self.categoryView.selectedIndexPath.row;
    LXClassifyListVC *vc = self.classifyVCList[@(idx)];
    if(vc) {
        [vc listDidDisappear];
    }
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
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        self.classifyVCList[@(index)] = vc;
    }
    LXLHCategoryModel *categoryModel = self.dataList[index];
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
        [self dismissFirstCategoryView];
    }];
    [[[RACObserve(self.listContainerView.scrollView, contentOffset) distinctUntilChanged]
      throttle:0.3]
     subscribeNext:^(id x) {
        @strongify(self)
        CGPoint contentOffset = [x CGPointValue];
        NSInteger page = floorf(contentOffset.x / SCREEN_WIDTH);
        NSLog(@"LXClassifyWrapperVC_page: %ld", page);
        [self.categoryView selectItemAtIndex:page];
        [self.allCategoryView selectItemAtIndex:page];
        [self.listContainerView didClickSelectedItemAtIndex:page];
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
    MASAttachKeys(self.labAll, self.imgViewShadowLeft, self.imgViewShadowRight, self.listContainerView, self.categoryView)
    [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(kFirstCategoryFoldHeight));
    }];
    [self.labAll mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
        make.width.equalTo(@(kLabelAllWidth));
    }];
    [self.imgViewShadowLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(@0.f);
    }];
    [self.imgViewShadowRight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.right.equalTo(self.labAll.mas_left);
    }];
    [self.listContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];

    [self.allMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_top);
        make.left.right.bottom.equalTo(@0.f);
    }];
    [self.allCategoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
            [weakSelf showFirstCategoryView];
        };

        _labAll = lab;
    }
    return _labAll;
}
- (LXFirstCategoryFoldView *)categoryView {
    if(!_categoryView){
        LXFirstCategoryFoldView *v = [[LXFirstCategoryFoldView alloc]init];

        v.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [v.flowLayout prepareLayout];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.allCategoryView selectItemAtIndex:idx];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
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


- (LXFirstCategoryUnfoldView *)allCategoryView {
    if(!_allCategoryView){
        LXFirstCategoryUnfoldView *v = [[LXFirstCategoryUnfoldView alloc]init];
        v.normalTextColor = [UIColor colorWithHex:0x333333];
        v.selectedTextColor = [UIColor colorWithHex:0xFFFFFF];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.categoryView selectItemAtIndex:idx];
                // [weakSelf.listContainerView didClickSelectedItemAtIndex:idx];
                [weakSelf dismissFirstCategoryView];
                [weakSelf.listContainerView.scrollView setContentOffset:CGPointMake(idx * weakSelf.listContainerView.scrollView.bounds.size.width, 0) animated:YES];
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
        // TODO: 「lxthyme」💊
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        v.frame = CGRectMake(0, kFirstCategoryFoldHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kFirstCategoryFoldHeight);
        // [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_CollectionView delegate:self];
        _listContainerView = v;
    }
    return _listContainerView;
}
- (NSString *)mockGoodsList {
    return @"[{\"id\":\"007780_2020007780ENT23234@@1@@168251\",\"basePrice\":\"1.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"168251\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2home-1/offlinegoods/goods/SP_263105405_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0919686001\",\"salePrice\":\"4.20\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"特种兵生榨椰子汁\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"特种兵\",\"popinfosList\":[{\"rules\":[{\"desc\":\"20元2件\",\"id\":\"4266\"}],\"activityType\":\"1\",\"memo\":\"动验证hwm-N元任选主题22\",\"labelDesc\":\"到家N元任选标\",\"goodsDetSid\":\"168251\",\"popDes\":\"20元2件\",\"ruleid\":\"54079\",\"ruletype\":\"7\",\"ruleName\":\"N元任选\",\"activityDesc\":\"活动验证hwm-到家-1\",\"activityId\":\"54100\",\"shopid\":\"007780\",\"sLabel\":\"到家N元任选标\",\"mLabel\":\"动验证hwm-N元任选主题22\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15645\":1000,\"15652\":1000,\"15654\":1,\"15656\":1000,\"15677\":1000,\"15809\":1631,\"15824\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@3364202\",\"basePrice\":\"20.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364202\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_1500659240_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90781679001\",\"salePrice\":\"26.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"汤臣倍健氨糖软骨素钙片180片\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"汤臣倍健\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":118,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1,\"15824\":1000}},{\"id\":\"200021_20402000211@@1@@3364201\",\"basePrice\":\"99.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364201\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_77581715_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90770879001\",\"salePrice\":\"99.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"日清草莓夹心黑可可300g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":57,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1,\"15784\":1000,\"15984\":1000}},{\"id\":\"200021_20402000211@@1@@3364204\",\"basePrice\":\"22.20\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364204\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_800781382_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90781692001\",\"salePrice\":\"19.98\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"果子九制话梅200g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"汤臣倍健\",\"popinfosList\":[{\"rules\":[{\"desc\":\"每满1件享9.0折\",\"id\":\"12637\"},{\"desc\":\"每满2件享8.0折\",\"id\":\"12638\"}],\"activityType\":\"1\",\"memo\":\"托底一件9折2件8折托满减主主\",\"labelDesc\":\"托底一件9折2件\",\"goodsDetSid\":\"3364204\",\"popDes\":\"满1件享9.0折\",\"ruleid\":\"52953\",\"discountType\":\"2\",\"conditionType\":\"2\",\"ruletype\":\"1\",\"ruleName\":\"满折\",\"activityDesc\":\"托底一件9折2件8折\",\"activityId\":\"52954\",\"shopid\":\"200021\",\"sLabel\":\"托底一件9折2件\",\"mLabel\":\"托底一件9折2件8折托满减主主\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":99,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1,\"15784\":1000,\"15824\":1}},{\"id\":\"007780_2020007780ENT23234@@1@@162675\",\"basePrice\":\"4.20\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162675\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000761074001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0761074001\",\"salePrice\":\"0.60\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1001\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":\"2\",\"productName\":\"可口可乐水动乐橙味营养素饮料600ml\",\"pointTitle\":null,\"saleStockSum\":5,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[{\"rules\":[{\"desc\":\"到家新人价1019\",\"id\":\"3702\"}],\"activityType\":\"1\",\"activityTag\":\"到家新人价1\",\"memo\":\"到家新人价1\",\"labelDesc\":\"到家新人价1\",\"goodsDetSid\":\"162675\",\"popDes\":\"买立减\",\"ruleid\":\"51044\",\"ruletype\":\"12\",\"ruleName\":\"专享\",\"activityId\":\"0\",\"shopid\":\"007780\",\"discountAmount\":\"0.6\",\"memberLimit\":\"10\",\"orderLimit\":\"2\",\"sLabel\":\"到家新人价1\",\"mLabel\":\"到家新人价1019\",\"lLabel\":\"到家新人价1019\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":2,\"15824\":1000}},{\"id\":\"200021_20402000211@@1@@3364203\",\"basePrice\":\"19.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364203\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_1297528873_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90781680001\",\"salePrice\":\"17.10\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"汤臣倍健（BY-HEALTH）氨糖软骨素钙片1.02g*50片\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"汤臣倍健\",\"popinfosList\":[{\"rules\":[{\"desc\":\"第1件9.0折\",\"id\":\"9181\"},{\"desc\":\"第2件8.0折\",\"id\":\"9182\"}],\"activityType\":\"1\",\"memo\":\"PLUS折扣1\",\"labelDesc\":\"PLUS折扣2\",\"goodsDetSid\":\"3364203\",\"popDes\":\"折扣\",\"ruleid\":\"53406\",\"ruletype\":\"2\",\"ruleName\":\"PLUS折扣\",\"activityDesc\":\"PLUS折扣到家412\",\"activityId\":\"53407\",\"shopid\":\"200021\",\"buyMember\":\"1\",\"sLabel\":\"PLUS折扣2\",\"mLabel\":\"PLUS折扣1\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":2,\"15824\":1000}},{\"id\":\"200021_20402000211@@1@@3364207\",\"basePrice\":\"29.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364207\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_546338816_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90781700001\",\"salePrice\":\"26.10\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"金亿丰牛肉干15g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[{\"rules\":[{\"desc\":\"每满1件享9.0折\",\"id\":\"12637\"},{\"desc\":\"每满2件享8.0折\",\"id\":\"12638\"}],\"activityType\":\"1\",\"memo\":\"托底一件9折2件8折托满减主主\",\"labelDesc\":\"托底一件9折2件\",\"goodsDetSid\":\"3364207\",\"popDes\":\"满1件享9.0折\",\"ruleid\":\"52953\",\"discountType\":\"2\",\"conditionType\":\"2\",\"ruletype\":\"1\",\"ruleName\":\"满折\",\"activityDesc\":\"托底一件9折2件8折\",\"activityId\":\"52954\",\"shopid\":\"200021\",\"sLabel\":\"托底一件9折2件\",\"mLabel\":\"托底一件9折2件8折托满减主主\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":2,\"15784\":1000,\"15824\":1000}},{\"id\":\"200021_20402000211@@1@@3364211\",\"basePrice\":\"18.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364211\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_1072260442_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90782779001\",\"salePrice\":\"16.20\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"散装小辣椒沙嗲牛肉干散装\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[{\"rules\":[{\"desc\":\"每满1件享9.0折\",\"id\":\"12637\"},{\"desc\":\"每满2件享8.0折\",\"id\":\"12638\"}],\"activityType\":\"1\",\"memo\":\"托底一件9折2件8折托满减主主\",\"labelDesc\":\"托底一件9折2件\",\"goodsDetSid\":\"3364211\",\"popDes\":\"满1件享9.0折\",\"ruleid\":\"52953\",\"discountType\":\"2\",\"conditionType\":\"2\",\"ruletype\":\"1\",\"ruleName\":\"满折\",\"activityDesc\":\"托底一件9折2件8折\",\"activityId\":\"52954\",\"shopid\":\"200021\",\"sLabel\":\"托底一件9折2件\",\"mLabel\":\"托底一件9折2件8折托满减主主\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":3,\"15784\":1000}},{\"id\":\"200021_20402000211@@1@@3364209\",\"basePrice\":\"45.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364209\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_2032187003_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90782774001\",\"salePrice\":\"41.22\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"散装牛筋滋味散装\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[{\"rules\":[{\"desc\":\"每满1件享9.0折\",\"id\":\"12637\"},{\"desc\":\"每满2件享8.0折\",\"id\":\"12638\"}],\"activityType\":\"1\",\"memo\":\"托底一件9折2件8折托满减主主\",\"labelDesc\":\"托底一件9折2件\",\"goodsDetSid\":\"3364209\",\"popDes\":\"满1件享9.0折\",\"ruleid\":\"52953\",\"discountType\":\"2\",\"conditionType\":\"2\",\"ruletype\":\"1\",\"ruleName\":\"满折\",\"activityDesc\":\"托底一件9折2件8折\",\"activityId\":\"52954\",\"shopid\":\"200021\",\"sLabel\":\"托底一件9折2件\",\"mLabel\":\"托底一件9折2件8折托满减主主\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":4,\"15784\":1000}},{\"id\":\"200021_20402000211@@1@@3364208\",\"basePrice\":\"21.50\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"3364208\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-4/offlinegoods/goods/SP_2146715726_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"90782735001\",\"salePrice\":\"9.00\",\"plusPrice\":\"10.00\",\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":\"10\",\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g万顺昌无花果120g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"万顺昌\",\"popinfosList\":[{\"rules\":[{\"desc\":\"每满1件享9.0折\",\"id\":\"12637\"},{\"desc\":\"每满2件享8.0折\",\"id\":\"12638\"}],\"activityType\":\"1\",\"memo\":\"托底一件9折2件8折托满减主主\",\"labelDesc\":\"托底一件9折2件\",\"goodsDetSid\":\"3364208\",\"popDes\":\"满1件享9.0折\",\"ruleid\":\"52953\",\"discountType\":\"2\",\"conditionType\":\"2\",\"ruletype\":\"1\",\"ruleName\":\"满折\",\"activityDesc\":\"托底一件9折2件8折\",\"activityId\":\"52954\",\"shopid\":\"200021\",\"sLabel\":\"托底一件9折2件\",\"mLabel\":\"托底一件9折2件8折托满减主主\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"2\",\"tdLable\":\"48H内发货\",\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":5,\"15665\":6,\"15784\":1000,\"15984\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@1003335\",\"basePrice\":\"32.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"1003335\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-2/offlinegoods/goods/SP_404692217_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0298077001\",\"salePrice\":\"30.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1001\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":\"1\",\"productName\":\"瑞士莲可可黑巧克力茅台100g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"Lazza\",\"popinfosList\":[{\"rules\":[{\"desc\":\"新人价活动名称\",\"id\":\"3481\"}],\"activityType\":\"1\",\"activityTag\":\"新人活动标签\",\"memo\":\"新人活动标签\",\"labelDesc\":\"新人活动标签\",\"goodsDetSid\":\"1003335\",\"popDes\":\"买立减\",\"ruleid\":\"50333\",\"ruletype\":\"12\",\"ruleName\":\"专享\",\"activityId\":\"0\",\"shopid\":\"007780\",\"discountAmount\":\"30.0\",\"memberLimit\":\"1\",\"orderLimit\":\"1\",\"sLabel\":\"新人活动标签\",\"mLabel\":\"新人价标签说明\",\"lLabel\":\"23453245345\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":3,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15665\":4}},{\"id\":\"007780_2020007780ENT23234@@1@@1003456\",\"basePrice\":\"11.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"1003456\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000599495001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0599495001\",\"salePrice\":\"22.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"12\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"隆力奇花露水195ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"隆力奇\",\"popinfosList\":[{\"labelDesc\":\"限时抢\",\"goodsDetSid\":\"1003456\",\"ruletype\":\"-1\",\"ruleName\":\"限时抢\",\"shopid\":\"007780\",\"memberLimit\":\"11\",\"sLabel\":\"限时抢\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":2,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15665\":7,\"15809\":8413}},{\"id\":\"007780_2020007780ENT23234@@1@@1003692\",\"basePrice\":\"108.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"1003692\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000929968001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0929968001\",\"salePrice\":\"108.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"星七红宝石奏鸣曲什锦曲奇饼干礼盒600g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"到家\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@131570\",\"basePrice\":\"29.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"131570\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2home-2/offlinegoods/goods/SP_989747843_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0665615001\",\"salePrice\":\"0.10\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"太平梳打1kg*6香葱1kg\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"太平\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000,\"15675\":6}},{\"id\":\"007780_2020007780ENT23234@@1@@133107\",\"basePrice\":\"10.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"133107\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000677760001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0677760001\",\"salePrice\":\"10.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"百加得冰锐苹果味朗姆预调酒275ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"百加得\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162559\",\"basePrice\":\"18.70\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162559\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000856441001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0856441001\",\"salePrice\":\"10.70\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1001\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":\"1\",\"productName\":\"好丽友畅快淋梨口香糖85g\",\"pointTitle\":null,\"saleStockSum\":3,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"全球购\",\"popinfosList\":[{\"rules\":[{\"desc\":\"到家满立减2000085644\",\"id\":\"3721\"}],\"activityType\":\"1\",\"activityTag\":\"到家满立减2\",\"memo\":\"到家满立减2\",\"labelDesc\":\"到家满立减2\",\"goodsDetSid\":\"162559\",\"popDes\":\"买立减\",\"ruleid\":\"51077\",\"ruletype\":\"12\",\"ruleName\":\"专享\",\"activityId\":\"0\",\"shopid\":\"007780\",\"discountAmount\":\"10.7\",\"memberLimit\":\"1\",\"orderLimit\":\"1\",\"sLabel\":\"到家满立减2\",\"mLabel\":\"到家满立减2000085644\",\"lLabel\":\"到家满立减2000085644\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162560\",\"basePrice\":\"12.53\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162560\",\"goodsImage\":\"https://img.st.iblimg.com/photo-10/2000/695071616_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0880497001\",\"salePrice\":\"11.28\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1002\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"【李炼】的乐事大波浪哇520g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"乐事\",\"popinfosList\":[{\"rules\":[{\"desc\":\"第1件9.0折\",\"id\":\"9181\"},{\"desc\":\"第2件8.0折\",\"id\":\"9182\"}],\"activityType\":\"1\",\"memo\":\"PLUS折扣1\",\"labelDesc\":\"PLUS折扣2\",\"goodsDetSid\":\"162560\",\"popDes\":\"折扣\",\"ruleid\":\"53406\",\"ruletype\":\"2\",\"ruleName\":\"PLUS折扣\",\"activityDesc\":\"PLUS折扣到家412\",\"activityId\":\"53407\",\"shopid\":\"007780\",\"buyMember\":\"1\",\"sLabel\":\"PLUS折扣2\",\"mLabel\":\"PLUS折扣1\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":5,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15667\":1000,\"15675\":7}},{\"id\":\"007780_2020007780ENT23234@@1@@162610\",\"basePrice\":\"59.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162610\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000808753001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0808753001\",\"salePrice\":\"49.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"1001\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":\"1\",\"productName\":\"养元六个核桃香纯型饮料240ml*12\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"养元\",\"popinfosList\":[{\"rules\":[{\"desc\":\"联华新人价回归\",\"id\":\"3508\"}],\"activityType\":\"1\",\"activityTag\":\"新人活动标签\",\"memo\":\"新人活动标签\",\"labelDesc\":\"新人活动标签\",\"goodsDetSid\":\"162610\",\"popDes\":\"买立减\",\"ruleid\":\"50481\",\"ruletype\":\"12\",\"ruleName\":\"专享\",\"activityId\":\"0\",\"shopid\":\"007780\",\"discountAmount\":\"49.0\",\"memberLimit\":\"1\",\"orderLimit\":\"1\",\"sLabel\":\"新人活动标签\",\"mLabel\":\"新人价标签说明\",\"lLabel\":\"20000856441001\"}],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162667\",\"basePrice\":\"10.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162667\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000837405001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0837405001\",\"salePrice\":\"10.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"品客加州田园牧场风味薯片110g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000,\"15665\":1000,\"15809\":5409}},{\"id\":\"007780_2020007780ENT23234@@1@@162680\",\"basePrice\":\"8000.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162680\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-2/offlinegoods/goods/SP_1861355871_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0809894001\",\"salePrice\":\"7777.00\",\"plusPrice\":\"1111.00\",\"discountPrice\":null,\"endTime\":null,\"priceType\":\"35\",\"limitBuyPersonSum\":\"10\",\"personLimit\":\"10\",\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"乐事孜然爆羊排味薯片\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"乐事\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15653\":1000,\"15654\":1000,\"15662\":1000,\"15674\":9,\"15809\":9599}},{\"id\":\"007780_2020007780ENT23234@@1@@162681\",\"basePrice\":\"5.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162681\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000809940001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0809940001\",\"salePrice\":\"5.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"34\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"李炼测试到家商品\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"乐事\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000,\"15667\":1000,\"15675\":8}},{\"id\":\"007780_2020007780ENT23234@@1@@162720\",\"basePrice\":\"10.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162720\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000782343001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0782343001\",\"salePrice\":\"10.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"百加得冰锐朗姆预调酒橙味310ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"百加得\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162721\",\"basePrice\":\"10.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162721\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000782377001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0782377001\",\"salePrice\":\"10.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"百加得冰锐朗姆预调酒蓝莓味310ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"百加得\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162724\",\"basePrice\":\"10.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162724\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000267260001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0267260001\",\"salePrice\":\"10.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"劲仔香辣小鱼50g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"劲仔\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162773\",\"basePrice\":\"23.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162773\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000507850001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0507850001\",\"salePrice\":\"23.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"奥妙全自动含金纺馨香精华洗衣液500g*3\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"奥妙\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162780\",\"basePrice\":\"12.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162780\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000841869001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0841869001\",\"salePrice\":\"12.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"锐澳柠檬味朗姆鸡尾酒500ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162781\",\"basePrice\":\"12.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162781\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000841876001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0841876001\",\"salePrice\":\"12.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"锐澳白桃味白兰地鸡尾酒500ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162877\",\"basePrice\":\"15.20\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162877\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000337017001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0337017001\",\"salePrice\":\"15.20\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"仲景原味香菇酱\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162909\",\"basePrice\":\"17.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162909\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000793669001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0793669001\",\"salePrice\":\"17.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茶花润巧运动杯\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@162950\",\"basePrice\":\"19.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"162950\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000793670001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0793670001\",\"salePrice\":\"19.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茶花多棱运动杯\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"茶花\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163070\",\"basePrice\":\"30.60\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163070\",\"goodsImage\":\"https://Img.st.iblimg.com/fast2homemethod-2/offlinegoods/goods/SP_1883112364_200x200.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0764083001\",\"salePrice\":\"30.60\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"威猛先生玻璃清洁剂双包装500g转规格商品转规格商品\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"到家\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15662\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163164\",\"basePrice\":\"33.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163164\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000834256001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0834256001\",\"salePrice\":\"33.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茗波龙井茶\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163189\",\"basePrice\":\"80.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163189\",\"goodsImage\":\"https://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000832813001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0832813001\",\"salePrice\":\"80.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"奥妙全自动含金纺馨香精华深层洁净洗衣液4kg\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"奥妙\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163210\",\"basePrice\":\"13.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163210\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000834288001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0834288001\",\"salePrice\":\"13.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茗波茉莉花\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163211\",\"basePrice\":\"12.30\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163211\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000834289001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0834289001\",\"salePrice\":\"12.30\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茗波决明子\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163212\",\"basePrice\":\"16.50\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163212\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000834290001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0834290001\",\"salePrice\":\"16.50\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"茗波玫瑰花\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"无品牌\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163238\",\"basePrice\":\"16.50\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163238\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830347001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830347001\",\"salePrice\":\"16.50\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华花清护清菊沁莲味牙膏180g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163239\",\"basePrice\":\"15.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163239\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830362001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830362001\",\"salePrice\":\"15.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"34\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华瓷感白花香龙井味牙膏180g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163241\",\"basePrice\":\"6.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163241\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830389001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830389001\",\"salePrice\":\"6.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华健齿白炫动果香味牙膏155g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163242\",\"basePrice\":\"7.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163242\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830390001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830390001\",\"salePrice\":\"7.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华健齿白炫动果香味牙膏200g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163254\",\"basePrice\":\"13.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163254\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830391001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830391001\",\"salePrice\":\"13.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华花清护清菊沁莲味牙膏140g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000,\"15668\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163255\",\"basePrice\":\"13.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163255\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830393001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830393001\",\"salePrice\":\"13.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华瓷感白花香龙井味牙膏140g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163257\",\"basePrice\":\"6.20\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163257\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830400001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830400001\",\"salePrice\":\"6.20\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华健齿白清新薄荷味牙膏155g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163258\",\"basePrice\":\"7.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163258\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000830449001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0830449001\",\"salePrice\":\"7.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"中华健齿白清新薄荷味牙膏200g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"缓缓\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163259\",\"basePrice\":\"23.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163259\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000831207001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0831207001\",\"salePrice\":\"23.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"多芬(Dove)男士护理去屑洁净强韧洗发露200ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"三叶草\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163260\",\"basePrice\":\"23.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163260\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000831208001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0831208001\",\"salePrice\":\"23.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"多芬(Dove)男士护理净透清爽强韧洗发露200ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"三叶草\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163261\",\"basePrice\":\"23.80\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163261\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000831213001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0831213001\",\"salePrice\":\"23.80\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"多芬(Dove)男士护理多效养护强韧洗发露200ml\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"三叶草\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163295\",\"basePrice\":\"109.00\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163295\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000857572001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0857572001\",\"salePrice\":\"109.00\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"吉列（Gillette）锋速3刀架刀片1支+4个\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"玛丽\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163302\",\"basePrice\":\"42.90\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163302\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000828910001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0828910001\",\"salePrice\":\"42.90\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"多芬(Dove)男士护理舒适净爽沐浴露650g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"三叶草\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}},{\"id\":\"007780_2020007780ENT23234@@1@@163303\",\"basePrice\":\"27.50\",\"categoryId\":null,\"comSid\":\"2000\",\"goodsId\":\"163303\",\"goodsImage\":\"http://img.st.iblimg.com/goods-14/2000/2016/11/SP_2000_20000828963001_01_1006.jpg\",\"goodsType\":null,\"inStock\":null,\"comGoodCode\":\"0828963001\",\"salePrice\":\"27.50\",\"plusPrice\":null,\"discountPrice\":null,\"endTime\":null,\"priceType\":\"0\",\"limitBuyPersonSum\":null,\"personLimit\":null,\"saleStockStatus\":\"1\",\"limitPopSum\":null,\"productName\":\"多芬(Dove)男士护理磨砂净肤沐浴露400g\",\"pointTitle\":null,\"saleStockSum\":11,\"marketOn\":\"1\",\"type\":null,\"brandCnName\":\"三叶草\",\"popinfosList\":[],\"previewList\":[],\"xgList\":[],\"from\":null,\"tdType\":\"0\",\"tdLable\":null,\"mainTitle\":null,\"minBuyQuan\":0,\"minBuySpec\":\"件\",\"pageCat\":{\"15654\":1000}}]";
}
@end
