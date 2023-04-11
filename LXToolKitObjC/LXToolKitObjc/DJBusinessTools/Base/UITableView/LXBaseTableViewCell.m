//
//  LXBaseTableViewCell.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseTableViewCell.h"
#import <Masonry/Masonry.h>
#import "DJLogger.h"

@interface LXBaseTableViewCell() {
}

@end

@implementation LXBaseTableViewCell
- (void)dealloc {
    commonlog(@"🛠DEALLOC[TableViewCell]: %@", NSStringFromClass([self class]));
}
#pragma mark -
#pragma mark - 🛠Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
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
