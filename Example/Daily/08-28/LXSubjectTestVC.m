//
//  LXSubjectTestVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/5.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXSubjectTestVC.h"

#import <Masonry/Masonry.h>

@interface LXSubjectTestVC() {
}
@property(nonatomic, strong)RACSubject *subject;
@property(nonatomic, strong)RACBehaviorSubject *behaviorSubject;
@property(nonatomic, strong)RACReplaySubject *replaySubject;

@end

@implementation LXSubjectTestVC
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
    [self testSubject];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)testSubject {
    self.subject = [RACSubject subject];
    [self.subject subscribeNext:^(id x) {
        NSLog(@"1-x: %@", x);
    }];
    [self.subject sendNext:@111];
    [self.subject subscribeNext:^(id x) {
        NSLog(@"2-x: %@", x);
    }];
    [self.subject sendNext:@222];
    [self.subject subscribeNext:^(id x) {
        NSLog(@"3-x: %@", x);
    }];
    [self.subject sendNext:@333];
}
- (void)testBehaviorSubject {
    self.behaviorSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@0];
    [self.behaviorSubject subscribeNext:^(id x) {
        NSLog(@"1-x: %@", x);
    }];
    [self.behaviorSubject sendNext:@111];
    [self.behaviorSubject subscribeNext:^(id x) {
        NSLog(@"2-x: %@", x);
    }];
    [self.behaviorSubject sendNext:@222];
    [self.behaviorSubject subscribeNext:^(id x) {
        NSLog(@"3-x: %@", x);
    }];
    [self.behaviorSubject sendNext:@333];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    // [self.<#view#> addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
