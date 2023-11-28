//
//  LXNested2VC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXNested2VC.h"

@interface LXNested2VC() {
}

@end

@implementation LXNested2VC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    [self prepareUI];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(@0.f);
    // }];
}

#pragma mark Lazy Property

@end
