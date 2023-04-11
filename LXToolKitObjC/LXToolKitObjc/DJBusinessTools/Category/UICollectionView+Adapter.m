//
//  UICollectionView+Adapter.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/10/31.
//

#import "UICollectionView+Adapter.h"
#import "NSObject+ex.h"

@implementation UICollectionView (Adapter)

- (__kindof UICollectionViewCell *)xl_dequeueReusableCell:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}
- (__kindof UICollectionReusableView *)xl_dequeueReusableForSectionHeader:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath {
    return [self xl_dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                withReuseIdentifier:reuseIdentifier
                                       forIndexPath:indexPath];
}
- (__kindof UICollectionReusableView *)xl_dequeueReusableForSectionFooter:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath {
    return [self xl_dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                withReuseIdentifier:reuseIdentifier
                                       forIndexPath:indexPath];
}
- (__kindof UICollectionReusableView *)xl_dequeueReusableSupplementaryViewOfKind:(NSString *)kind
                              withReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}
/// 注册 cell
/// ReuseIdentifier: **CellClass.xl_identifier**
- (void)xl_registerForCell:(Class)CellClass {
    [self registerClass:CellClass forCellWithReuseIdentifier:CellClass.xl_identifier];
}

- (void)xl_registerForSectionHeader:(Class)HeaderFooterClass {
    [self xl_registerforSupplementaryViewOfKind:UICollectionElementKindSectionHeader withClass:HeaderFooterClass];
}

- (void)xl_registerForSectionFooter:(Class)HeaderFooterClass {
    [self xl_registerforSupplementaryViewOfKind:UICollectionElementKindSectionFooter withClass:HeaderFooterClass];
}

/// 注册 header or footer
/// ReuseIdentifier: **HeaderFooterClass.xl_identifier**
- (void)xl_registerforSupplementaryViewOfKind:(NSString *)kind withClass:(Class)HeaderFooterClass {
    [self registerClass:HeaderFooterClass
forSupplementaryViewOfKind:kind
    withReuseIdentifier:HeaderFooterClass.xl_identifier];
}

@end
