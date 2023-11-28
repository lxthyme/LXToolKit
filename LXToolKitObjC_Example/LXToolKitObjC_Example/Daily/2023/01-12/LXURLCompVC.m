//
//  LXURLCompVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/1/12.
//  Copyright © 2023 lxthyme. All rights reserved.
//
#import "LXURLCompVC.h"

#import <Masonry/Masonry.h>

@interface LXURLCompVC() {
}

@end

@implementation LXURLCompVC
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
    [self testM];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)testM {
    NSURLComponents *comp = [NSURLComponents componentsWithString:@"https://mh5.bl.com/bl-free-web/view?viewId=63a270a77c74a6008f4b68c9"];
    BOOL containStoreCode = [comp.queryItems.rac_sequence filter:^BOOL(NSURLQueryItem *value) {
        return [value.name isEqualToString:@"storeCode"];
    }].array.count > 0;
    BOOL containShopId = [comp.queryItems.rac_sequence filter:^BOOL(NSURLQueryItem *value) {
        return [value.name isEqualToString:@"shopId"];
    }].array.count > 0;
    if(!containStoreCode || !containShopId) {
        NSMutableArray *queryItems = [NSMutableArray array];
        [queryItems addObjectsFromArray:comp.queryItems];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"storeCode" value:@"1"]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"buid" value:@"2"]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"merchantId" value:@"3"]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"shopId" value:@"4"]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"bizId" value:@"5"]];
        comp.queryItems = queryItems;
    }
    NSLog(@"comp: %@", comp);
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
