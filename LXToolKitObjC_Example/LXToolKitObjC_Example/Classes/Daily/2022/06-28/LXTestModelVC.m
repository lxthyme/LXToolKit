//
//  LXTestModelVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXTestModelVC.h"
#import "LXTestModel.h"

#import <Masonry/Masonry.h>

@interface LXTestModelVC() {
}

@end

@implementation LXTestModelVC
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
    [self test];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)test {
    LXTestModel *model = [LXTestModel yy_modelWithJSON:@{
        @"test1": @"test1",
        @"test2": @"test2",
        @"test3": @"test3",
        @"test4": @"test4",
        @"test5": @"test5",
        @"name1": @"name1",
        @"name2": @"name2",
        @"name3": @"name3",
        @"name4": @"name4",
        @"name5": @"name5",
    }];
    NSLog(@"model: %@", model.yy_modelToJSONString);
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
