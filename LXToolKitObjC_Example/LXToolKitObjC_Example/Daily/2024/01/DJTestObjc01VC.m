//
//  DJTestObjc01VC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2024/2/2.
//
#import "DJTestObjc01VC.h"

#import <Masonry/Masonry.h>

@interface DJTestObjc01VC() {
}
@property(nonatomic, strong)UIButton *btnTest;
@property(nonatomic, assign)BOOL status;

@end

@implementation DJTestObjc01VC
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
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)btnTestClick:(UIButton *)sender {
    [self testMethod];
}

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)testMethod {
    // self.status = YES;
    if(self.status) {
        [self performSelector:@selector(setStatus:) withObject:@(NO) afterDelay:0.2];
    } else {
        [self performSelector:@selector(setStatus:) withObject:@(YES) afterDelay:0.2];
    }
}
- (void)toggleStatus:(NSNumber *)status2 {
    BOOL status = [status2 boolValue];
    NSLog(@"-->status: %@ -> %@", kBOOLString(self.status), kBOOLString(status));
    // self.view maket
    self.status = status;
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.view addSubview:self.btnTest];

    [self masonry];
}
#pragma mark getter / setter
- (void)setStatus:(BOOL)status {
    // if(_status == status) {
    //     return;
    // }
    NSLog(@"-->status: %@ -> %@", kBOOLString(_status), kBOOLString(status));
    _status = status;
}
#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    [self.btnTest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
        make.width.equalTo(@80.f);
        make.height.equalTo(@44);
    }];
}

#pragma mark Lazy Property
- (UIButton *)btnTest {
    if(!_btnTest){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // btn.backgroundColor = [UIColor <#whiteColor#>];

        [btn setTitle:@"Test" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnTestClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnTest = btn;
    }
    return _btnTest;
}
@end
