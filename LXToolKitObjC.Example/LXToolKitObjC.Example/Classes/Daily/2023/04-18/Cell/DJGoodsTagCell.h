//
//  DJGoodsTagCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>

#define kGoodsTagViewHeight kWPercentage(14.f)

NS_ASSUME_NONNULL_BEGIN

@interface DJGoodsTagCell: LXBaseCollectionViewCell {
}

- (void)dataFill:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
