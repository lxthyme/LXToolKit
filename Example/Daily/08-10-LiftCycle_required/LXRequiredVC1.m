//
//  LXRequiredVC1.m
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "LXRequiredVC1.h"

@interface LXRequiredVC1 ()

@end

@implementation LXRequiredVC1

- (void)viewWillAppear:(BOOL)animated __attribute__((objc_requires_super)) {
    [super viewWillAppear:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
