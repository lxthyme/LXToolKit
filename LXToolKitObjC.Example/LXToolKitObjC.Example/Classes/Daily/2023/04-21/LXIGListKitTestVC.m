//
//  LXIGListKitTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/21.
//
#import "LXIGListKitTestVC.h"

#import <Masonry/Masonry.h>

@interface LXIGListKitTestVC() {
}

@end

@implementation LXIGListKitTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - ✈️IGListSectionController
// - (CGSize)sizeForItemAtIndex:(NSInteger)index {
//     return CGSizeMake(self.collectionContext.containerSize.width, 55.f);
// }
// - (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    // self.view.backgroundColor = [UIColor whiteColor];

    // [self.<#view#> addSubview:self.<#table#>];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
}

#pragma mark Lazy Property

@end
