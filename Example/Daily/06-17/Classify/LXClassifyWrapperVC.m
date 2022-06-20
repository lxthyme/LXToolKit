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

@interface LXClassifyWrapperVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
}
@property (nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)YYLabel *labAll;
@property (nonatomic, strong)JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;

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
}

#pragma mark -
#pragma mark - 🌎LoadData

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
    LXClassifyListVC *vc = [[LXClassifyListVC alloc]init];
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
}
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
    [self.view addSubview:self.labAll];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0.f);
        make.height.equalTo(@(80.f));
    }];
    [self.labAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView.mas_right);
        make.right.equalTo(@0.f);
        make.width.equalTo(@44.f);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
        // make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (YYLabel *)labAll {
    if(!_labAll){
        YYLabel *lab = [[YYLabel alloc]init];
        lab.text = @"全部";
        lab.textColor = [UIColor blackColor];
        lab.verticalForm = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        lab.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectZero]];
        lab.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"233");
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.categoryView.collectionView.collectionViewLayout;
            if(layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
                layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            } else {
                layout.scrollDirection = UICollectionViewScrollDirectionVertical;

            }
            [layout prepareLayout];
            [self.categoryView.collectionView setNeedsLayout];
            [self.categoryView.collectionView layoutIfNeeded];
            CGSize contentSize = self.categoryView.collectionView.contentSize;
            CGRect frame = self.categoryView.collectionView.frame;
            frame.size = contentSize;
            self.categoryView.frame = frame;
            NSLog(@"%@", NSStringFromCGRect(frame));
        };

        _labAll = lab;
    }
    return _labAll;
}
- (JXCategoryTitleImageView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleImageView *v = [[JXCategoryTitleImageView alloc]init];
        v.imageZoomEnabled = YES;
        v.imageZoomScale = 1.3f;
        v.averageCellSpacingEnabled = NO;
        // v.cellWidth = 60.f;
        v.imageSize = CGSizeMake(40.f, 40.f);
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
