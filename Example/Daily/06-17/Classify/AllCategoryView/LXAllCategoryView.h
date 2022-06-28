//
//  LXAllCategoryView.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <LXToolKitObjc/LXBaseView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXAllCategoryView : LXBaseView {
}
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, copy)void (^didSelectRowBlock)(NSIndexPath *ip);

- (void)selectItemAtIndexPath:(NSIndexPath *)ip;

@end

NS_ASSUME_NONNULL_END
