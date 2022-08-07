//
//  DJClassifyListBannerCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/8/7.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <SDCycleScrollView/SDCollectionViewCell.h>
#import "FLAnimatedImageView.h"
#import <YYImage/YYImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListBannerCell: SDCollectionViewCell {
}
@property(nonatomic, weak)YYAnimatedImageView *imageView;

@end

NS_ASSUME_NONNULL_END
