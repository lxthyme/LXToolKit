//
//  LXViewController.m
//  LXToolKitObjc
//
//  Created by lxthyme on 05/25/2022.
//  Copyright (c) 2022 lxthyme. All rights reserved.
//

#import "LXViewController.h"

@interface LXViewController () {
}

@end

@implementation LXViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self prepareUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)prepareUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

    // [self.view addSubview:self.table];
    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // UIView *superView = self.view;
    // [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(@0.f);
    // }];
}

#pragma mark Lazy Property

@end
