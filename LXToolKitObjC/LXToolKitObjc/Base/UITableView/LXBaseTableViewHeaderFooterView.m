//
//  LXBaseTableViewHeaderFooterView.m
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseTableViewHeaderFooterView.h"
#import <Masonry/Masonry.h>
#import "LXLogger.h"

@interface LXBaseTableViewHeaderFooterView() {
}

@end

@implementation LXBaseTableViewHeaderFooterView
- (void)dealloc {
    commonlog(@"🛠DEALLOC[TableViewHeaderFooterView]: %@", NSStringFromClass([self class]));
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithReuseIdentifier:reuseIdentifier]) {
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
