//
//  LXTestBorderVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXTestBorderVC.h"

#import "UIView+border.h"

@interface LXTestBorderVC() {
}
@property (nonatomic, strong)UIView *redView;

@end

@implementation LXTestBorderVC
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
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.redView];
    MASAttachKeys(self.redView);
    [self.view setMas_key:@"LXTestBorderVC.view"];
    [self.redView xl_addBorder:UIRectEdgeTop | UIRectEdgeBottom
                         color:[UIColor blueColor]
                         inset:0.f
                     thickness:1.f];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.height.equalTo(@300.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)redView {
    if(!_redView){
        UIView *v = [[UIView alloc]init];
        // v.backgroundColor = [UIColor redColor];
        _redView = v;
    }
    return _redView;
}
@end
