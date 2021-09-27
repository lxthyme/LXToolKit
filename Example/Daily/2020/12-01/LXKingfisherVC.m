//
//  LXKingfisherVC.m
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/12/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "LXKingfisherVC.h"
#import <SDWebImage.h>
#import <LXToolKit-Swift.h>
#import <LXToolKit_Exam-Swift.h>

@interface LXKingfisherVC () {
}

@end

@implementation LXKingfisherVC

- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}
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
}
- (void)test123 {
    NSURL *url = [NSURL URLWithString:@""];
    NSLog(@"URL: %@", url);
//    LXTest *test = [[LXTest alloc]init];
//    LXEm
//    url.ca
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
//    NSArray<UIView *> *array = @[<#table#>];
//    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.view addSubview:obj];
//    }];
    [self masonry];
}
- (void)masonry {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
