//
//  UICollectionView+Adapter.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Adapter)

- (__kindof UICollectionViewCell *)xl_dequeueReusableCell:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionReusableView *)xl_dequeueReusableForSectionHeader:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionReusableView *)xl_dequeueReusableForSectionFooter:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionReusableView *)xl_dequeueReusableSupplementaryViewOfKind:(NSString *)kind
                              withReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath;
/// 注册 cell
/// ReuseIdentifier: **CellClass.xl_identifier**
- (void)xl_registerForCell:(Class)CellClass;
- (void)xl_registerForSectionHeader:(Class)HeaderFooterClass;
- (void)xl_registerForSectionFooter:(Class)HeaderFooterClass;
/// 注册 header or footer
/// ReuseIdentifier: **HeaderFooterClass.xl_identifier**
- (void)xl_registerforSupplementaryViewOfKind:(NSString *)kind withClass:(Class)HeaderFooterClass;

@end

NS_ASSUME_NONNULL_END
