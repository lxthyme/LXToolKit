//
//  DJClassifyListLeftCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJClassifyListLeftCell : LXBaseTableViewCell {
}

- (void)dataFill:(NSString *)title logo:(NSString * _Nullable)urlString;

@end

NS_ASSUME_NONNULL_END
