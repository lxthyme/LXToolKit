//
//  LXBaseCollectionViewCell.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "DJLogger.h"

@interface LXBaseCollectionViewCell() {
}

@end

@implementation LXBaseCollectionViewCell
- (void)dealloc {
    commonlog(@"🛠DEALLOC[CollectionViewCell]: %@", NSStringFromClass([self class]));
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
    [self.contentView setMas_key:[NSString stringWithFormat:@"%@.contentView", clsName]];
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property
@end
