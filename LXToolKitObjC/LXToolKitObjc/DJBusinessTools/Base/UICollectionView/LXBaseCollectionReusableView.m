//
//  LXBaseCollectionReusableView.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseCollectionReusableView.h"
#import <Masonry/Masonry.h>
#import "DJLogger.h"

@interface LXBaseCollectionReusableView() {
}

@end

@implementation LXBaseCollectionReusableView
- (void)dealloc {
    commonlog(@"🛠DEALLOC[CollectionReusableView]: %@", NSStringFromClass([self class]));
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
