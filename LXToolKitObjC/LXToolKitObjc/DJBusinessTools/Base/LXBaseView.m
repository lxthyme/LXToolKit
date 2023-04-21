//
//  LXBaseView.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseView.h"
#import <Masonry/Masonry.h>
#import "DJLogger.h"

@interface LXBaseView() {
}

@end

@implementation LXBaseView
- (void)dealloc {
    commonlog(@"🛠DEALLOC[View]: %@", NSStringFromClass([self class]));
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)init {
    if(self = [super init]) {
        [self basePrepareUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self basePrepareUI];
    }
    return self;
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
    [self setMas_key:clsName];
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property
@end
