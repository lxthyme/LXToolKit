//
//  LXFirstCategoryView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <LXToolKitObjc/LXBaseView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXFirstCategoryView : LXBaseView {
}
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong, readonly)NSIndexPath *_Nullable selectedIndexPath;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSInteger idx);

- (void)selectItemAtIndex:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
