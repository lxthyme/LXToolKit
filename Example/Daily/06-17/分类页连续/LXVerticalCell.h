//
//  LXVerticalCell.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/20.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXClassifyListVC.h"
#import "LXSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXVerticalCell : UICollectionViewCell {
}
@property(nonatomic, strong)LXClassifyListVC *classifyListVC;

- (void)dataFill:(LXCategoryModel *)cateogryModel;

@end

NS_ASSUME_NONNULL_END
