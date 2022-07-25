//
//  LXBaseVC.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseVC.h"
#import <Masonry/Masonry.h>

@interface LXBaseVC() {
}

@end

@implementation LXBaseVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    [self basePrepareUI];
}

#pragma mark -
#pragma mark - 📌UI Prepare & Masonry
- (void)basePrepareUI {
    [self baseMasonry];
}
#pragma mark getter / setter
#pragma mark Masonry
- (void)baseMasonry {
    NSString *clsName = NSStringFromClass([self class]);
    [self.view setMas_key:[NSString stringWithFormat:@"%@.view", clsName]];
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property
@end
