//
//  LXTestBorderVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/7/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXTestBorderVC.h"

#import "UIView+border.h"

@interface LXTestBorderVC() {
}
@property (nonatomic, strong)UIView *redView;
@property(nonatomic, strong)RACSubject *shopResourseSubject;

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

    // [self testSendCompleted];
    [self testSendError];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testSendCompleted {
    self.shopResourseSubject = [RACSubject subject];
    [self.shopResourseSubject subscribeNext:^(id x) {
        NSLog(@"1. subscribeNext: %@", x);
    } error:^(NSError *error) {
        NSLog(@"2. error: %@", error);
    } completed:^{
        NSLog(@"3. completed");
    }];
    [self.shopResourseSubject sendNext:@1];
    [self.shopResourseSubject sendNext:@2];
    [self.shopResourseSubject sendCompleted];
    [self.shopResourseSubject sendNext:@3];
    [self.shopResourseSubject sendNext:@4];
}
- (void)testSendError {
    self.shopResourseSubject = [RACSubject subject];
    [self.shopResourseSubject subscribeNext:^(id x) {
        NSLog(@"1. subscribeNext: %@", x);
    } error:^(NSError *error) {
        NSLog(@"2. error: %@", error);
    } completed:^{
        NSLog(@"3. completed");
    }];
    [self.shopResourseSubject sendNext:@1];
    [self.shopResourseSubject sendNext:@2];
    [self.shopResourseSubject sendError:[NSError errorWithDomain:@"999" code:-999 userInfo:@{}]];
    [self.shopResourseSubject sendNext:@3];
    [self.shopResourseSubject sendNext:@4];
}

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
