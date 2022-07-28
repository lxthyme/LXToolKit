//
//  LXClassifyListLeftView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseView.h>

#import "LXClassifyBaseCategoryModel.h"

typedef NS_ENUM(NSInteger, LXClassifyLeftScrollType) {
    LXClassifyLeftScrollTypePrevious = 1,
    LXClassifyLeftScrollTypeNext = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXClassifyListLeftView : LXBaseView {
}
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)dataFill:(NSArray<LXClassifyBaseCategoryModel *> *)dataList;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)ip;

@end

NS_ASSUME_NONNULL_END
