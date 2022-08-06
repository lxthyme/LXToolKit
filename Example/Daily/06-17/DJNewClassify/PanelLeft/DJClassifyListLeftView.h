//
//  DJClassifyListLeftView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseView.h>

#import "DJClassifyBaseCategoryModel.h"
#import "DJClassifyMacro.h"

typedef NS_ENUM(NSInteger, DJClassifyLeftScrollType) {
    DJClassifyLeftScrollTypePrevious = 1,
    DJClassifyLeftScrollTypeNext = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListLeftView : LXBaseView {
}
@property(nonatomic, assign)DJClassifyType classifyType;
@property(nonatomic, assign)NSInteger currentIdx;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)dataFill:(NSArray<DJClassifyBaseCategoryModel *> *)dataList;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)ip;

@end

NS_ASSUME_NONNULL_END
