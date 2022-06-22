//
//  LXPageVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXPageVC.h"

#import "LXClassifyListVC.h"
#import "LXClassifyListLeftView.h"

static const CGFloat kLeftTableWidth = 100.f;

@interface LXPageVC()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
}
@property(nonatomic, strong)LXClassifyListLeftView *panelLeftView;
@property(nonatomic, strong)LXCategoryModel *categoryModel;
@property(nonatomic, strong)UIPageViewController *pageVC;
@property(nonatomic, copy)NSArray *dataList;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, LXClassifyListVC *> *classifyVCList;
@end

@implementation LXPageVC
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
    LXClassifyListVC *vc = [self vcAtIdx:0];
    [vc dataFill2:categoryModel.subCategoryList.firstObject];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSInteger)idxOfVC:(LXClassifyListVC *)vc {
    RACSequence<RACTwoTuple<NSNumber *, LXClassifyListVC *> *> *seq = [self.classifyVCList.rac_sequence filter:^BOOL(RACTwoTuple<NSNumber *, LXClassifyListVC *> *_Nullable value) {
        return [value.second isEqual:vc];
    }];
    if(seq.head == nil) {
        return NSNotFound;
    }
    return [seq.head.first integerValue];
}
- (LXClassifyListVC *)vcAtIdx:(NSInteger)idx {
    if(idx < 0 || idx >= self.categoryModel.subCategoryList.count) {
        return nil;
    }
    LXClassifyListVC *vc = self.classifyVCList[@(idx)];
    if(!vc) {
        vc = [[LXClassifyListVC alloc]init];
        vc.view.tag = idx;
        self.classifyVCList[@(idx)] = vc;
    }
    return vc;
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
    LXClassifyListVC *vc = [self vcAtIdx:idx - 1];
    LXSubCategoryModel *subCategoryModel = self.categoryModel.subCategoryList[idx - 1];
    [vc dataFill2:subCategoryModel];
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger idx = viewController.view.tag;
    if(idx >= self.categoryModel.subCategoryList.count - 1) {
        return nil;
    }
    LXClassifyListVC *vc = [self vcAtIdx:idx + 1];
    LXSubCategoryModel *subCategoryModel = self.categoryModel.subCategoryList[idx + 1];
    [vc dataFill2:subCategoryModel];
    return vc;
}

#pragma mark -
#pragma mark - ✈️UIPageViewControllerDelegate

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self addChildViewController:self.pageVC];
    LXClassifyListVC *vc = [self vcAtIdx:0];
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
        make.top.left.bottom.equalTo(@0.f);
        make.width.equalTo(@(kLeftTableWidth));
    }];
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0.f);
        make.left.equalTo(self.panelLeftView.mas_right);
    }];
}

#pragma mark Lazy Property
- (NSMutableDictionary<NSNumber *, LXClassifyListVC *> *)classifyVCList {
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
        v.didSelectRowBlock = ^(NSIndexPath * _Nonnull ip) {
            if(ip.row < weakSelf.categoryModel.subCategoryList.count) {
                LXSubCategoryModel *subCategoryModel = weakSelf.categoryModel.subCategoryList[ip.row];
                LXClassifyListVC *vc = [weakSelf vcAtIdx:ip.row];
                [vc dataFill2:subCategoryModel];
                NSInteger previousIdx = [weakSelf idxOfVC:weakSelf.pageVC.viewControllers.firstObject];
                UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
                if(previousIdx > ip.row) {
                    direction = UIPageViewControllerNavigationDirectionReverse;
                }
                [weakSelf.pageVC setViewControllers:@[vc]
                                          direction: direction
                                           animated:YES
                                         completion:nil];
            }
        };

        _panelLeftView = v;
    }
    return _panelLeftView;
}
@end
