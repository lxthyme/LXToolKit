//
//  LXDJSearchHistoryCell.h
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>
#import <LXToolKitObjC/LXBaseCollectionViewCell.h>

// kWPercentage(27.f)
#define kSearchHistoryCellHeight 27.f

NS_ASSUME_NONNULL_BEGIN

@interface LXDJSearchHistoryCell: LXBaseCollectionViewCell {
}

- (void)data:(NSDictionary *)item;
- (CGFloat)calcCellSize:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
