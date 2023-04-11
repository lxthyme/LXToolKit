//
//  ViewController.m
//  DJTest
//
//  Created by lxthyme on 2023/3/31.
//

#import "ViewController.h"
#import "LXSwiftOCTestVC.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    LXSwiftOCTestVC *vc = [[LXSwiftOCTestVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
