//
//  LXClassifySectionHeaderView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifySectionHeaderView : UICollectionReusableView {
}

- (void)dataFill:(LXSectionModel *)model;

@end

NS_ASSUME_NONNULL_END
