//
//  LXBaseControl.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/10/13.
//
#import "LXBaseControl.h"

#import <Masonry/Masonry.h>
#import "LXLogger.h"

@interface LXBaseControl() {
}

@end

@implementation LXBaseControl
- (void)dealloc {
    // commonlog(@"🛠DEALLOC[UIControl]: %@", NSStringFromClass([self class]));
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self basePrepareUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)basePrepareUI {
    self.backgroundColor = [UIColor whiteColor];

    // [self addSubview:self.<#table#>];
    [self baseMasonry];
}

#pragma mark Masonry
- (void)baseMasonry {
    // MASAttachKeys(<#...#>)
    NSString *clsName = NSStringFromClass([self class]);
    [self setMas_key:clsName];
}

#pragma mark Lazy Property

@end
