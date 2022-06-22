//
//  LXClassifyListLeftView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "LXSectionModel.h"

typedef NS_ENUM(NSInteger, LXClassifyLeftScrollType) {
    LXClassifyLeftScrollTypePrevious = 1,
    LXClassifyLeftScrollTypeNext = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListLeftView : LXBaseView {
}
@property(nonatomic, copy)void (^didSelectRowBlock)(NSIndexPath *ip);

- (void)dataFill:(NSArray<LXSubCategoryModel *> *)dataList;

- (BOOL)scrollToPreviousRow;
- (BOOL)scrollToNextRow;

@end

NS_ASSUME_NONNULL_END
