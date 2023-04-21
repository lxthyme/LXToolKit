//
//  LXRecommendListView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXRecommendListView.h"

#import <JXCategoryView/JXCategoryView.h>
#import "LXPageListView.h"
#import "UIWindow+JXSafeArea.h"

@interface LXRecommendListView() {
}
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LXRecommendListView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT - 50.f);
    [self addSubview:self.categoryView];
    [self addSubview:self.scrollView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0.f);
        make.height.equalTo(@50.f);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom);
        make.left.right.bottom.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIScrollView *)scrollView {
    if(!_scrollView){
        UIScrollView *v = [[UIScrollView alloc]init];
        v.pagingEnabled = YES;
        v.bounces = NO;
        if (@available(iOS 11.0, *)) {
            v.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = SCREEN_HEIGHT - naviHeight - 50.f;
        LXPageListView *powerListView = [[LXPageListView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        powerListView.isFirstLoaded = YES;
        powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
        [v addSubview:powerListView];

        LXPageListView *hobbyListView = [[LXPageListView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        hobbyListView.isFirstLoaded = YES;
        hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
        [v addSubview:hobbyListView];

        LXPageListView *partnerListView = [[LXPageListView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
        partnerListView.isFirstLoaded = YES;
        partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
        [v addSubview:partnerListView];

        _scrollView = v;
    }
    return _scrollView;
}
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.titles = @[@"能力", @"爱好", @"队友"];

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorLineWidth = 30;
        v.indicators = @[lineView];

        //添加分割线，这个完全自己配置
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 50.f - 1, SCREEN_WIDTH, 1)];
        separatorView.backgroundColor = [UIColor lightGrayColor];
        [v addSubview:separatorView];

        v.contentScrollView = self.scrollView;

        _categoryView = v;
    }
    return _categoryView;
}
@end
