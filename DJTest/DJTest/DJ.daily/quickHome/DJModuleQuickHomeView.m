//
//  DJModuleQuickHomeView.m
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import "DJModuleQuickHomeView.h"

#import <Masonry/Masonry.h>
#import <DJBusinessModule/DJClassifyO2ORightVC.h>

@interface DJModuleQuickHomeView() {
}

@end

@implementation DJModuleQuickHomeView
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithRefreshBlock:(void (^)(void))refreshPageListView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.classifyO2OVC = [[DJClassifyO2OVC alloc]init];
        self.classifyO2OVC.classifyVM = [[DJClassifyVM alloc]init];
        self.classifyO2OVC.refreshPageListView = refreshPageListView;
        [self prepareUI];

        [[AFNetworkReachabilityManager sharedManager] startMonitoring];

        /// 刷新专享券数据
        [self.classifyO2OVC.classifyVM.couponVM reloadAllCouponList];
    }
    return self;
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️JXPageListViewListDelegate
- (UIScrollView *)listScrollView {
    DJClassifyO2ORightVC *vc = self.classifyO2OVC.pageVC.viewControllers.firstObject;
    if([vc isKindOfClass:[DJClassifyO2ORightVC class]]) {
        return vc.table;
    }
    return nil;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    DJClassifyO2ORightVC *vc = self.classifyO2OVC.pageVC.viewControllers.firstObject;
    if([vc isKindOfClass:[DJClassifyO2ORightVC class]]) {
        vc.scrollCallback = callback;
    }
}
- (void)listViewLoadDataIfNeeded {
    NSLog(@"-->listViewLoadDataIfNeeded");
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.classifyO2OVC.view];

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
