//
//  UITableView+Adapter.h
//  DJBusinessTools
//
//  Created by lxthyme on 2021/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Adapter)


/// UITableView iOS 各版本适配
/// @param parentVC parentVC(可选)
- (void)adapterWithParentVC:(UIViewController * _Nullable)parentVC;

- (__kindof UITableViewCell *)xl_dequeueReusableCell:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath;
- (nullable __kindof UITableViewHeaderFooterView *)xl_dequeueReusableHeaderFooterView:(NSString *)reuseIdentifier;
/// 注册 cell
/// ReuseIdentifier: **CellClass.xl_identifier**
- (void)xl_registerForCell:(Class)CellClass;
/// 注册 header or footer
/// ReuseIdentifier: **HeaderFooterClass.xl_identifier**
- (void)xl_registerForHeaderFooterView:(Class)HeaderFooterClass;

@end

NS_ASSUME_NONNULL_END
