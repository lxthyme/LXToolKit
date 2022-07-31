//
//  LXClassifyListVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListVC.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <DJBusinessTools/iPhoneX.h>

#import "LXClassifyListRightVC.h"
#import "LXClassifyListLeftView.h"
#import "LXClassifyEmptyView.h"
// @import DJBusinessModuleSwift;

@interface LXClassifyListVC()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
}
@property(nonatomic, strong)LXClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)LXClassifyListModel *classifyListModel;
@property(nonatomic, strong)UIPageViewController *pageVC;
@property(nonatomic, strong)UIImageView *imgViewLeftCorner;
@property(nonatomic, strong)UIImageView *imgViewRightCorner;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListRightVC *> *classifyVCList;
@property(nonatomic, strong)LXClassifyEmptyView *emptyView;
/// 页面状态
@property(nonatomic, assign)LXViewStatus viewStatus;

@end

@implementation LXClassifyListVC
#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    // !self.toggleSkeletonScreenBlock ?: self.toggleSkeletonScreenBlock(NO);
    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData
- (void)dataFill:(LXClassifyListModel *)classifyListModel {
    if(classifyListModel.f_categorys.count > 0) {
        self.viewStatus = LXViewStatusNormal;
    } else {
        self.viewStatus = LXViewStatusNoData;
    }
    self.classifyListModel = classifyListModel;
    [self.panelLeftView dataFill:classifyListModel.f_categorys];

    // NSString *firstCategoryId = classifyListModel.f_categorys.firstObject.categoryId;
    // [self dataFillRightVCAtIdx:0
    //                 categoryId:firstCategoryId
    //                    showAll:YES];
}
- (void)dataFillRightVCAtIdx:(NSInteger)idx
                  categoryId:(NSString *)categoryId
                     showAll:(BOOL)showAll {
    if(idx < 0 || idx >= self.classifyListModel.f_categorys.count) {
        return;
    }
    LXClassifyRightModel *rightModel = self.classifyListModel.f_rightModelList[categoryId];
    switch (rightModel.f_itemType) {
        case LXClassifyGoodItemTypeB2C: {
            if(rightModel.f_goodsInfoModel) {
                LXClassifyListRightVC *vc = [self vcAtIdx:idx];
                [vc dataFill:rightModel showAll:showAll];
            } else {
                [self.b2cVM loadV2SearchForLHApi:rightModel.f_2rdCategoryId];
            }
        }
            break;
        case LXClassifyGoodItemTypeO2O: {
            BOOL hadFilled = NO;
            if(showAll && rightModel.f_showAll) {
                if(rightModel.f_goodsInfoModel) {
                    LXClassifyListRightVC *vc = [self vcAtIdx:idx];
                    [vc dataFill:rightModel showAll:showAll];
                    hadFilled = YES;
                }
            } else {
                if(rightModel.f_o2oGoodsInfoList) {
                    LXClassifyListRightVC *vc = [self vcAtIdx:idx];
                    [vc dataFill:rightModel showAll:showAll];
                    hadFilled = YES;
                }
            }
            if(!hadFilled) {
                /// 此处请求第一个三级分类的数据, 需要判断是否为"全部"
                LXClassifyBaseCategoryModel *categoryModel = [self.classifyListModel.f_categorys.rac_sequence filter:^BOOL(LXClassifyBaseCategoryModel *value) {
                    return [value.categoryId isEqualToString:categoryId];
                }].head;
                if(categoryModel && [categoryModel isKindOfClass:[DJO2OCategoryListModel class]]) {
                    DJO2OCategoryListModel *o2oCategoryModel = (DJO2OCategoryListModel *)categoryModel;
                    [self.b2cVM loadSearchGoodsDetailsWith:o2oCategoryModel.categoryId
                                                endCateIds:o2oCategoryModel.endCateIds
                                                     isAll:o2oCategoryModel.showAll == 1];
                }
            }
        }
            break;

        case LXClassifyGoodItemTypePinCategoryView:
        case LXClassifyGoodItemTypeEmpty:
            break;
    }
}
- (void)updateGoodItem:(NSString *)categoryId goodsInfoList:(LXClassifyGoodsInfoModel *)goodsInfoList {
    LXClassifyRightModel *rightModel = self.classifyListModel.f_rightModelList[categoryId];
    NSMutableDictionary *categoryMap = [NSMutableDictionary dictionary];
    for (LXClassifyBaseCategoryModel *item in rightModel.f_categorys) {
        if(item.categoryId) {
            categoryMap[item.categoryId] = item;
        }
    }
    /// 填充 each section 商品对应的 category 数据
    goodsInfoList.f_itemType = LXClassifyGoodItemTypeB2C;
    goodsInfoList.f_b2cCategoryMdeol = categoryMap[goodsInfoList.f_2rdCategoryId];

    rightModel.f_goodsInfoModel = goodsInfoList;
    // rightModel.f_allSectionGoodsInfoModel = allSectionList;
    NSInteger idx = self.pageVC.viewControllers.firstObject.view.tag;
    [self dataFillRightVCAtIdx:idx
                    categoryId:categoryId
                       showAll:YES];
}
- (void)updateGoodItemOnlyAll:(NSString *)categoryId goodsInfoList:(NSArray<LXClassifyGoodsInfoModel *> *)goodsInfoList {
    LXClassifyRightModel *rightModel = self.classifyListModel.f_rightModelList[categoryId];
    NSMutableDictionary *categoryMap = [NSMutableDictionary dictionary];
    for (LXClassifyBaseCategoryModel *item in rightModel.f_categorys) {
        if(item.categoryId) {
            categoryMap[item.categoryId] = item;
        }
    }
    /// 填充 each section 商品对应的 category 数据
    LXClassifyGoodsInfoModel *allInfo = goodsInfoList.firstObject;
    allInfo.f_itemType = LXClassifyGoodItemTypeO2O;
    allInfo.f_o2oCategoryMdeol = categoryMap[allInfo.f_o2oGoodsInfo.cateId];

    rightModel.f_goodsInfoModel = allInfo;
    NSInteger idx = self.pageVC.viewControllers.firstObject.view.tag;
    [self dataFillRightVCAtIdx:idx
                    categoryId:categoryId
                       showAll:YES];
}
- (void)updateGoodItemAllSection:(NSString *)categoryId goodsInfoList:(NSArray<LXClassifyGoodsInfoModel *> *)goodsInfoList {
    LXClassifyRightModel *rightModel = self.classifyListModel.f_rightModelList[categoryId];
    NSMutableDictionary *categoryMap = [NSMutableDictionary dictionary];
    for (LXClassifyBaseCategoryModel *item in rightModel.f_categorys) {
        if(item.categoryId) {
            categoryMap[item.categoryId] = item;
        }
    }
    /// 填充 each section 商品对应的 category 数据
    [goodsInfoList enumerateObjectsUsingBlock:^(LXClassifyGoodsInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.f_itemType == LXClassifyGoodItemTypeB2C) {
            obj.f_b2cCategoryMdeol = categoryMap[obj.f_2rdCategoryId];
        } else if(obj.f_itemType == LXClassifyGoodItemTypeO2O) {
            obj.f_o2oCategoryMdeol = categoryMap[obj.f_o2oGoodsInfo.cateId];
        }
    }];
    /// 组装 all section  商品数据
    NSMutableDictionary *goodsInfoMap = [NSMutableDictionary dictionary];
    for (LXClassifyGoodsInfoModel *item in goodsInfoList) {
        if(!isEmptyString(item.f_o2oCategoryMdeol.categoryId)) {
            goodsInfoMap[item.f_o2oCategoryMdeol.categoryId] = item;
        }
    }
    NSMutableArray *allSectionList = [NSMutableArray array];
    for (LXClassifyBaseCategoryModel *item in rightModel.f_categorys) {
        if(!isEmptyString(item.categoryId) &&
           ![item.categoryId isEqualToString:@"-1"]) {
            LXClassifyGoodsInfoModel *goodsInfo = goodsInfoMap[item.categoryId];
            [allSectionList addObject:goodsInfo];
        }
    }
    rightModel.f_o2oGoodsInfoList = allSectionList;
    NSInteger idx = self.pageVC.viewControllers.firstObject.view.tag;
    [self dataFillRightVCAtIdx:idx
                    categoryId:categoryId
                       showAll:NO];
}
#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSInteger)idxOfVC:(LXClassifyListRightVC *)vc {
    /// <RACTuple<NSNumber *, LXClassifyListRightVC *> *>
    /// <NSNumber *, LXClassifyListRightVC *>
    RACSequence *seq = [self.classifyVCList.rac_sequence filter:^BOOL(RACTuple *_Nullable value) {
        return [value.second isEqual:vc];
    }];
    if(seq.head == nil) {
        return NSNotFound;
    }
    if([seq.head isKindOfClass:[RACTuple class]]) {
        RACTuple *headTuple = seq.head;
        return [headTuple.first integerValue];
    }
    return NSNotFound;
}
- (LXClassifyListRightVC *)vcAtIdx:(NSInteger)idx {
    LXClassifyListRightVC *vc = self.classifyVCList[@(idx)];
    if(!vc) {
        vc = [[LXClassifyListRightVC alloc]init];
        vc.classifyType = self.classifyType;
        vc.b2cVM = self.b2cVM;
        vc.view.tag = idx;
        WEAKSELF(self)
        vc.refreshBlock = ^(BOOL isRefresh) {
            if(isRefresh) {
                [weakSelf pageVCScrollToIdx:idx - 1];
            } else {
                [weakSelf pageVCScrollToIdx:idx + 1];
            }
        };
        self.classifyVCList[@(idx)] = vc;
    }
    return vc;
}
- (void)pageVCScrollToIdx:(NSInteger)idx {
    if(idx < 0 || idx >= self.classifyListModel.f_categorys.count) {
        return;
    }
    /// 1. 隐藏当前 VC
    LXClassifyListRightVC *tmp_beforeVC = (LXClassifyListRightVC *)self.pageVC.viewControllers.firstObject;
    [tmp_beforeVC dismissAllCategoryView];
    /// 2. 切换到下一个 VC
    LXClassifyListRightVC *vc = [self vcAtIdx:idx];
    if(idx >= 0 && idx < self.classifyListModel.f_categorys.count) {
        NSString *categoryId = self.classifyListModel.f_categorys[idx].categoryId;
        [self dataFillRightVCAtIdx:idx
                        categoryId:categoryId
                           showAll:YES];
    }

    NSInteger previousIdx = [self idxOfVC:self.pageVC.viewControllers.firstObject];
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if(previousIdx > idx) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    // [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.panelLeftView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    [self.pageVC setViewControllers:@[vc]
                          direction: direction
                           animated:YES
                         completion:nil];
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listDidAppear {
    NSInteger idx = self.pageVC.viewControllers.firstObject.view.tag;
    if(idx >= 0 && idx < self.classifyListModel.f_categorys.count) {
        NSString *categoryId = self.classifyListModel.f_categorys[idx].categoryId;
        // LXClassifyRightModel *rightModel = self.classifyListModel.f_rightModelList[categoryId];
        // if(rightModel.f_goodsInfoModel) {
        //     LXClassifyListRightVC *vc = [self vcAtIdx:idx];
        //     [vc dataFill:rightModel showAll:YES];
        // }
        [self dataFillRightVCAtIdx:idx
                        categoryId:categoryId
                           showAll:YES];
    }
}
- (void)listDidDisappear {
    /// 容器在隐藏时, 隐藏各种弹窗
    [self.pageVC.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[LXClassifyListRightVC class]]) {
            LXClassifyListRightVC *vc = (LXClassifyListRightVC *)obj;
            [vc dismissAllCategoryView];
        }
    }];
}

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    /// 1. 隐藏当前 VC
    LXClassifyListRightVC *tmp_beforeVC = (LXClassifyListRightVC *)viewController;
    [tmp_beforeVC dismissAllCategoryView];
    /// 2. 切换到当前 VC
    NSInteger idx = viewController.view.tag;
    if(idx <= 0) {
        return nil;
    }
    LXClassifyListRightVC *vc = [self vcAtIdx:idx - 1];
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    /// 1. 隐藏当前 VC
    LXClassifyListRightVC *tmp_afterVC = (LXClassifyListRightVC *)viewController;
    [tmp_afterVC dismissAllCategoryView];
    /// 2. 切换到当前 VC
    NSInteger idx = viewController.view.tag;
    if(idx >= self.classifyListModel.f_categorys.count - 1) {
        return nil;
    }
    LXClassifyListRightVC *vc = [self vcAtIdx:idx + 1];
    return vc;
}

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDelegate

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self addChildViewController:self.pageVC];
    LXClassifyListRightVC *vc = [self vcAtIdx:0];
    self.classifyVCList[@0] = vc;
    [self.pageVC setViewControllers:@[vc]
                          direction:UIPageViewControllerNavigationDirectionReverse
                           animated:YES
                         completion:nil];
    [self.view addSubview:self.panelLeftView];
    [self.view addSubview:self.pageVC.view];
    [self.view addSubview:self.imgViewLeftCorner];
    [self.view addSubview:self.imgViewRightCorner];
    [self.view addSubview:self.emptyView];

    [self masonry];
}
#pragma mark getter / setter
- (void)setViewStatus:(LXViewStatus)viewStatus {
    if(_viewStatus == viewStatus) {
        return;
    }
    _viewStatus = viewStatus;

    self.emptyView.hidden = YES;
    // self.classifySkeletonScreen.hidden = YES;
    switch (viewStatus) {
        case LXViewStatusUnknown:
            break;
        case LXViewStatusNormal:
            break;
        case LXViewStatusLoading:
            // self.classifySkeletonScreen.hidden = NO;
            break;
        case LXViewStatusNoData:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillEmptyStyle];
            break;
        case LXViewStatusOffline:
            self.emptyView.hidden = NO;
            [self.emptyView dataFillOfflineStyle];
            break;
    }
}
#pragma mark Masonry
- (void)masonry {
    MASAttachKeys(self.panelLeftView, self.pageVC.view, self.imgViewLeftCorner, self.imgViewRightCorner)
    [self.panelLeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
    }];
    [self.pageVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0.f);
        make.left.equalTo(self.panelLeftView.mas_right);
    }];
    [self.imgViewLeftCorner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.panelLeftView);
        make.width.height.equalTo(@(kWPercentage(10.f)));
    }];
    [self.imgViewRightCorner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.pageVC.view);
        make.width.height.equalTo(@(kWPercentage(10.f)));
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, LXClassifyListRightVC *> *)classifyVCList {
    if(!_classifyVCList){
        _classifyVCList = [NSMutableDictionary dictionary];
    }
    return _classifyVCList;
}
- (UIPageViewController *)pageVC {
    if(!_pageVC){
        UIPageViewController *v = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:@{
            UIPageViewControllerOptionInterPageSpacingKey: @0.f
        }];
        v.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        v.delegate = self;
        // v.dataSource = self;
        _pageVC = v;
    }
    return _pageVC;
}
- (LXClassifyListLeftView *)panelLeftView {
    if(!_panelLeftView){
        LXClassifyListLeftView *v = [[LXClassifyListLeftView alloc]init];
        v.classifyType = self.classifyType;
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            [weakSelf pageVCScrollToIdx:idx];
        };
        _panelLeftView = v;
    }
    return _panelLeftView;
}
- (UIImageView *)imgViewLeftCorner {
    if(!_imgViewLeftCorner){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_left_corner"];
        _imgViewLeftCorner = iv;
    }
    return _imgViewLeftCorner;
}
- (UIImageView *)imgViewRightCorner {
    if(!_imgViewRightCorner){
        UIImageView *iv = [[UIImageView alloc]init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [iBLImage imageNamed:@"icon_right_corner"];
        _imgViewRightCorner = iv;
    }
    return _imgViewRightCorner;
}
- (LXClassifyEmptyView *)emptyView {
    if(!_emptyView){
        LXClassifyEmptyView *v = [[LXClassifyEmptyView alloc]init];
        v.hidden = YES;
        _emptyView = v;
    }
    return _emptyView;
}


@end
