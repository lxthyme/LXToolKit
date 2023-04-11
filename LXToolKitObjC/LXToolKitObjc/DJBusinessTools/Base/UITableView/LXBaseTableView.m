//
//  LXBaseTableView.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseTableView.h"
#import <Masonry/Masonry.h>
#import "DJLogger.h"

@interface LXBaseTableView() {
}

@end

@implementation LXBaseTableView
- (void)dealloc {
    commonlog(@"🛠DEALLOC[TableView]: %@", NSStringFromClass([self class]));
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if(self = [super initWithFrame:frame style:style]) {
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
