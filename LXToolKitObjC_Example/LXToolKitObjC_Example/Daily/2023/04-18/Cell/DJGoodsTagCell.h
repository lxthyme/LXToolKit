//
//  DJGoodsTagCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>
#import <LXToolKitObjC/LXBaseCollectionViewCell.h>

#define kDJGoodsTagViewHeight kWPercentage(14.f)

NS_ASSUME_NONNULL_BEGIN

@interface DJGoodsTagCell: LXBaseCollectionViewCell {
}
@property(nonatomic, strong)UIStackView *contentStackView;

- (void)dataFill:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
