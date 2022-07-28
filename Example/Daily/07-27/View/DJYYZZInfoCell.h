//
//  DJYYZZInfoCell.h
//  DJBusinessModule
//
//  Created by lxthyme on 2022/7/20.
//
#import <UIKit/UIKit.h>

#import "DJYYZZInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJYYZZInfoCell: UICollectionViewCell {
}

- (void)dataFill:(DJYYZZInfoModel *)item;

@end

NS_ASSUME_NONNULL_END
