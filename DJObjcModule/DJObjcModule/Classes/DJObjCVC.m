//
//  DJObjCVC.m
//  DJObjcModule
//
//  Created by lxthyme on 2023/3/31.
//
#import "DJObjCVC.h"

#import <Masonry/Masonry.h>
// #import "DJObjcModule-Swift.h"
#import <DJBusinessModuleSwift/DJBusinessModuleSwift-Swift.h>

@interface DJObjCVC() {
}
@property(nonatomic, strong)UILabel *labTitle;

@end

@implementation DJObjCVC
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
    // DJSwiftTest *test = [[DJSwiftTest alloc]init];
    // LXTestVC *testVC = [test testVC];
    DJBusinessModuleSwiftVC *testVC = [[DJBusinessModuleSwiftVC alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.labTitle];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UILabel *)labTitle {
    if(!_labTitle){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"Objc";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor blackColor];
        // label.backgroundColor = [UIColor cyanColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        _labTitle = label;
    }
    return _labTitle;
}
@end
