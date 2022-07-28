//
//  LXYYZZImageCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DJYYZZInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXYYZZImageCell: UICollectionViewCell {
}

- (void)dataFill:(DJYYZZInfoModel *)item isLeft:(BOOL)isLeft;

@end

NS_ASSUME_NONNULL_END
