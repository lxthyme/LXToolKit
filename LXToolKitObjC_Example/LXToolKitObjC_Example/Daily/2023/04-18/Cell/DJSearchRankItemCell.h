//
//  DJSearchRankItemCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>
#import <LXToolKitObjC/LXBaseTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJSearchRankItemCell: LXBaseTableViewCell {
}

- (void)dataFill:(NSDictionary *)item;

@end

NS_ASSUME_NONNULL_END
