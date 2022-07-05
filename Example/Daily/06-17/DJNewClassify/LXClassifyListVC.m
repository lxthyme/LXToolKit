//
//  LXClassifyListVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXClassifyListVC.h"

#import "LXClassifyListRightVC.h"
#import "LXClassifyListLeftView.h"

@interface LXClassifyListVC()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
}
@property(nonatomic, strong)LXClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)LXCategoryModel *categoryModel;
@property(nonatomic, strong)UIPageViewController *pageVC;
@property(nonatomic, copy)NSArray *dataList;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListRightVC *> *classifyVCList;
@end

@implementation LXClassifyListVC
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
- (void)dataFill:(LXCategoryModel *)categoryModel; {
    self.categoryModel = categoryModel;
    [self.panelLeftView dataFill:categoryModel.subCategoryList];
    LXClassifyListRightVC *vc = [self vcAtIdx:0];
    [vc dataFill:categoryModel.subCategoryList.firstObject];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSInteger)idxOfVC:(LXClassifyListRightVC *)vc {
    RACSequence<RACTwoTuple<NSNumber *, LXClassifyListRightVC *> *> *seq = [self.classifyVCList.rac_sequence filter:^BOOL(RACTwoTuple<NSNumber *, LXClassifyListRightVC *> *_Nullable value) {
        return [value.second isEqual:vc];
    }];
    if(seq.head == nil) {
        return NSNotFound;
    }
    return [seq.head.first integerValue];
}
- (LXClassifyListRightVC *)vcAtIdx:(NSInteger)idx {
    LXClassifyListRightVC *vc = self.classifyVCList[@(idx)];
    if(!vc) {
        vc = [[LXClassifyListRightVC alloc]init];
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
    if(idx < 0 || idx >= self.categoryModel.subCategoryList.count) {
        return;
    }
    LXClassifyListRightVC *vc = [self vcAtIdx:idx];
    LXSubCategoryModel *subCategoryModel = self.categoryModel.subCategoryList[idx];
    [vc dataFill:subCategoryModel];

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

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger idx = viewController.view.tag;
    if(idx <= 0) {
        return nil;
    }
    LXClassifyListRightVC *vc = [self vcAtIdx:idx - 1];
    LXSubCategoryModel *subCategoryModel = self.categoryModel.subCategoryList[idx - 1];
    [vc dataFill:subCategoryModel];
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger idx = viewController.view.tag;
    if(idx >= self.categoryModel.subCategoryList.count - 1) {
        return nil;
    }
    LXClassifyListRightVC *vc = [self vcAtIdx:idx + 1];
    LXSubCategoryModel *subCategoryModel = self.categoryModel.subCategoryList[idx + 1];
    [vc dataFill:subCategoryModel];
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

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.panelLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
        make.bottom.equalTo(@(-iPhoneX.xl_safeareaInsets.bottom));
    }];
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0.f);
        make.left.equalTo(self.panelLeftView.mas_right);
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
    if(!_pageVC){//<#UIPageViewControllerDelegate, UIPageViewControllerDataSource#>
        UIPageViewController *v = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:@{
            UIPageViewControllerOptionInterPageSpacingKey: @0.f
        }];
        v.delegate = self;
        // v.dataSource = self;
        _pageVC = v;
    }
    return _pageVC;
}
- (LXClassifyListLeftView *)panelLeftView {
    if(!_panelLeftView){
        LXClassifyListLeftView *v = [[LXClassifyListLeftView alloc]init];
        WEAKSELF(self)
        v.didSelectRowBlock = ^(NSInteger idx) {
            [weakSelf pageVCScrollToIdx:idx];
        };
        _panelLeftView = v;
    }
    return _panelLeftView;
}
@end
