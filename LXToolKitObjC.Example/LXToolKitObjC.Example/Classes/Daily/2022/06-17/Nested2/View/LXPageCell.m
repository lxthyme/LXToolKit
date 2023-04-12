//
//  LXPageCell.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXPageCell.h"

#import "LXListViewController.h"
#import <LXToolKitObjC/LXMacro.h>

static const CGFloat JXheightForHeaderInSection = 50;

@interface LXPageCell()<JXCategoryViewDelegate, JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate, UIScrollViewDelegate, UITableViewDelegate> {
}
@property (nonatomic, strong)JXPagerView *pagerView;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray<NSString *> *titles;
@property(nonatomic, assign)CGPoint beginPoint;
@property(nonatomic, assign)CGPoint movePoint;

@end

@implementation LXPageCell
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark -
#pragma mark - ✈️UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"offsetY: %f", scrollView.contentOffset.y);
}


#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    // self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -
#pragma mark - ✈️JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return [UIView new];
}
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.categoryView.titles.count;
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    LXListViewController *listVC = [[LXListViewController alloc]init];
    listVC.title = self.titles[index];
    listVC.isNeedHeader = self.isNeedHeader;
    listVC.isNeedFooter = self.isNeedFooter;
    if (index == 0) {
        listVC.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮[END]"].mutableCopy;
    }else if (index == 1) {
        listVC.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉[END]"].mutableCopy;
    }else {
        listVC.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾[END]"].mutableCopy;
    }
    return listVC;
    // return self.listViewArray[index];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    // self.pagerView.pinSectionHeaderVerticalOffset = 200.f;
    // self.pagerView.mainTableView.delaysContentTouches = NO;
    // self.pagerView.mainTableView.canCancelContentTouches = NO;
    self.pagerView.mainTableView.bounces = NO;
    self.titles = @[@"能力", @"爱好", @"队友"];
    [self.contentView addSubview:self.pagerView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, JXheightForHeaderInSection);
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]initWithFrame:frame];
        v.backgroundColor = [UIColor whiteColor];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.contentScrollViewClickTransitionAnimationEnabled = NO;
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc]init];
        lineView.indicatorColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorWidth = 30;
        v.indicators = @[lineView];

        v.delegate = self;
        v.titles = self.titles;

        // TODO: 「lxthyme」💊
        // v.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;

        _categoryView = v;
    }
    return _categoryView;
}
- (JXPagerView *)pagerView {
    if(!_pagerView){
        JXPagerView *v = [[JXPagerView alloc]initWithDelegate:self];
        v.mainTableView.gestureDelegate = self;
        _pagerView = v;
    }
    return _pagerView;
}
@end
