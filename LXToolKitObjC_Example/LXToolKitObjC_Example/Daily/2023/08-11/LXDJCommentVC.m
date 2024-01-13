//
//  LXDJCommentVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import "LXDJCommentVC.h"

#import <Masonry/Masonry.h>
#import "LXJXCategoryCustomView.h"

#import "LXDJCommentChildVC.h"

#define kDJCommentCategoryBackgroundHeight 30.f

@interface LXDJCommentVC()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate> {
}
@property(nonatomic, strong)LXJXCategoryCustomView *categoryView;
@property(nonatomic, strong)JXCategoryListContainerView *listContainerView;

@property(nonatomic, copy)NSArray *titleList;
@property(nonatomic, copy)NSArray<NSAttributedString *> *attributeTitleList;
@property(nonatomic, copy)NSArray<NSAttributedString *> *selectedAttributeTitleList;

@end

@implementation LXDJCommentVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
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
    // 处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
    // 离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
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

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (NSAttributedString *)makeAttr:(NSString *)title count:(NSInteger)count isSelected:(BOOL)isSelected {
    if(isSelected) {
        return [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %ld", title, count] attributes:@{
            NSForegroundColorAttributeName: [UIColor colorWithHex:0xFF4515],
            NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(13.f)],
        }];
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr appendAttributedString:[[NSAttributedString alloc]initWithString:title
                                                                attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithHex:0x333333],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(13.f)],
    }]];
    [attr appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %ld", count]
                                                                attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithHex:0x999999],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:kWPercentage(13.f)],
    }]];
    return [attr copy];
}

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    // 侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -
#pragma mark - ✈️JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleList.count;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LXDJCommentChildVC *childVC = [[LXDJCommentChildVC alloc]init];
    return childVC;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"商品评价";

    self.titleList = @[
        @"全部",
        @"好评",
        @"有图"
    ];
    self.categoryView.titles = self.titleList;
    self.categoryView.attributeTitles = [self.titleList.rac_sequence map:^id(NSString *value) {
        return [self makeAttr:value count:3800 isSelected:NO];
    }].array;
    self.categoryView.selectedAttributeTitles = [self.titleList.rac_sequence map:^id(NSString *value) {
        return [self makeAttr:value count:3800 isSelected:YES];
    }].array;
    // self.categoryView.listContainer = self.listContainerView;

    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@44.f);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        LXJXCategoryCustomView *v = [[LXJXCategoryCustomView alloc]init];
        v.titleColorGradientEnabled = NO;
        v.averageCellSpacingEnabled = NO;
        v.contentEdgeInsetLeft = 15.f;
        v.contentEdgeInsetRight = 15.f;
        v.cellWidthIncrement = 30.f;
        v.cellSpacing = 10.f;
        v.normalBackgroundColor = [UIColor colorWithHex:0xF4F6FA];
        v.selectedBackgroundColor = [UIColor colorWithHex:0xFF4515 alpha:0.1f];
        v.backgroundCornerRadius = kDJCommentCategoryBackgroundHeight / 2.f;
        v.backgroundHeight = kDJCommentCategoryBackgroundHeight;
        v.borderLineWidth = 0.f;
        v.delegate = self;

        // JXCategoryIndicatorBackgroundView *bgView = [[JXCategoryIndicatorBackgroundView alloc]init];
        // bgView.indicatorHeight = 30.f;
        // bgView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        // bgView.indicatorColor = [UIColor colorWithHex:0xFF4515];
        // v.indicators = @[bgView];

        _categoryView = v;
    }
    return _categoryView;
}
- (JXCategoryListContainerView *)listContainerView {
    if(!_listContainerView){
        // JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        JXCategoryListContainerView *v = [[JXCategoryListContainerView alloc]initWithDelegate:self];
        // v.backgroundColor = [UIColor <#whiteColor#>];
        _listContainerView = v;
    }
    return _listContainerView;
}

@end
