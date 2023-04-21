//
//  LXViewController.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 04/11/2023.
//  Copyright (c) 2023 lxthyme. All rights reserved.
//

#import "LXViewController.h"
// #import <LXToolKitObjC_Example/LXToolKitObjC_Example.h>
#import <LXToolKitObjC_Example/LXToolKitObjCTestVC.h>
@interface LXViewController ()

@end

@implementation LXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LXToolKitObjCTestVC *vc = [[LXToolKitObjCTestVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
