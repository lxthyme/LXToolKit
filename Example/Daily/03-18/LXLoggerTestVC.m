//
//  LXLoggerTestVC.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/3/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "LXLoggerTestVC.h"

#import "LXLoggerObjc.h"

@interface LXLoggerTestVC() {
}

@end

@implementation LXLoggerTestVC
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
    self.view.backgroundColor = [UIColor whiteColor];

    [self prepareUI];
    [self test233];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)test233 {
    NSString *str = @"123";
    NSLog(@"-->%@: %@", fmtVar(str), str);
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {// <#[self prepareUI];#>
    self.view.backgroundColor = [UIColor whiteColor];

    // [self.<#view#> addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {// <#[self masonry];#> <##import <Masonry/Masonry.h>#>
    // MASAttachKeys(<#...#>)
    // UIView *superView = self.view;
}

#pragma mark Lazy Property

@end
