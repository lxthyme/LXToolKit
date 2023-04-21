//
//  LXSectionHeaderView.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSectionHeaderView.h"

#import <JXCategoryView/JXCategoryView.h>

@interface LXSectionHeaderView()<JXCategoryViewDelegate> {
}
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSArray<NSString *> *titles;

@end

@implementation LXSectionHeaderView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXCategoryViewDelegate

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    self.titles = @[@"主题一", @"主题二", @"主题三"];
    self.categoryView.titles = self.titles;

    [self addSubview:self.categoryView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView){
        JXCategoryTitleView *v = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
        v.backgroundColor = [UIColor greenColor];
        v.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        v.titleColor = [UIColor blackColor];
        v.titleColorGradientEnabled = YES;
        v.titleLabelZoomEnabled = YES;
        v.titleLabelZoomScale = 1.2;
        v.delegate = self;
        _categoryView = v;
    }
    return _categoryView;
}
@end
