//
//  LXTestStringVC.m
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "LXTestStringVC.h"

@interface LXTestStringVC ()
/** <#label#>*/
@property(nonatomic, strong)NSString *string;
@end

@implementation LXTestStringVC

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
    [self testM];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
//    NSArray<UIView *> *array = @[<#table#>];
//    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.view addSubview:obj];
//    }];
//    [self masonry];
}
- (void)masonry {}

- (void)testM {
    self.string = @"undefined";
    NSLog(@"1. string: %@", self.string);

    NSString *str1 = @"2333";
    self.string = str1;
    NSLog(@"2. string: %@\tstr1: %@", self.string, str1);

    str1 = @"2334567890";
    NSLog(@"3. string: %@\tstr1: %@", self.string, str1);

    NSMutableString *str2 = [NSMutableString stringWithString:@"muString"];
    self.string = str2;
    NSLog(@"4. string: %@\tstr2: %@", self.string, str2);

    [str2 appendString:@"-------"];
    NSLog(@"5. string: %@\tstr2: %@", self.string, str2);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
