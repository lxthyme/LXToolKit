//
//  LXPageVC.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/17.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPageVC : UIViewController {
}
@property (nonatomic, assign) BOOL isNeedHeader;
@property (nonatomic, assign) BOOL listViewScrollStateSaveEnabled;
@property (nonatomic, assign) CGFloat pinCategoryViewVerticalOffset;
@property (nonatomic, assign) BOOL isNeedScrollToBottom;

@end

NS_ASSUME_NONNULL_END
