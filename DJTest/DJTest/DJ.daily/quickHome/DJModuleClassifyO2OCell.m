//
//  DJModuleClassifyO2OCell.m
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import "DJModuleClassifyO2OCell.h"

#import <Masonry/Masonry.h>
#import <DJBusinessModule/DJClassifyQuicklyO2OVC.h>

@interface DJModuleClassifyO2OCell() {
}

@end

@implementation DJModuleClassifyO2OCell
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
#pragma mark - 🌎LoadData
- (void)dataFill:(DJJSCateSlideModel *)quicklyModel {
    self.classifyO2OVC.classifyVM.quicklyModel = quicklyModel;
    // [self.classifyO2OVC reloadData];
    /// 刷新专享券数据
    [self.classifyO2OVC.classifyVM.couponVM reloadAllCouponList];
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.classifyO2OVC = [[DJClassifyQuicklyO2OVC alloc]init];
    self.classifyO2OVC.classifyVM = [[DJClassifyVM alloc]init];
    [[UIViewController topViewController] addChildViewController:self.classifyO2OVC];
    [self.contentView addSubview:self.classifyO2OVC.view];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.classifyO2OVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0.f);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
}

#pragma mark Lazy Property
@end
