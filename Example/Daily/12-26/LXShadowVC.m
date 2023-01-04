//
//  LXShadowVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/12/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXShadowVC.h"

#import <Masonry/Masonry.h>

@interface LXShadowVC() {
}
@property(nonatomic, strong)UIView *shadowView;

@end

@implementation LXShadowVC
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
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
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
    [self testArray];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testArray {
    NSArray *a = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSLog(@"a: %@", a);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.shadowView];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
        make.left.right.equalTo(@0.f);
        make.height.equalTo(@10);
    }];
}

#pragma mark Lazy Property
- (UIView *)shadowView {
    if(!_shadowView){
        UIView *v = [[UIView alloc]init];
        // v.backgroundColor = [UIColor whiteColor];
        v.layer.shadowColor = [UIColor colorWithHex:0x000000 alpha:1.f].CGColor;
        v.layer.shadowOffset = CGSizeMake(0, 2);
        v.layer.shadowOpacity = 1;
        v.layer.shadowRadius = kWPercentage(10.f);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, SCREEN_WIDTH, 10));
        v.layer.shadowPath = path;
        CGPathRelease(path);
        _shadowView = v;
    }
    return _shadowView;
}

@end
