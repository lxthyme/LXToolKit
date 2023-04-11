//
//  UITableView+Adapter.m
//  DJBusinessTools
//
//  Created by lxthyme on 2021/12/16.
//

#import "UITableView+Adapter.h"
#import "NSObject+ex.h"

@implementation UITableView (Adapter)

- (void)adapterWithParentVC:(UIViewController * _Nullable)parentVC {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else if(parentVC != nil && [parentVC isKindOfClass:[UIViewController class]]) {
        parentVC.automaticallyAdjustsScrollViewInsets = NO;
    }
    if(@available(iOS 13.0, *)) {
        self.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    if(@available(iOS 15.0, *)) {
        self.sectionHeaderTopPadding = 0.f;
    }
}
- (__kindof UITableViewCell *)xl_dequeueReusableCell:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}
- (nullable __kindof UITableViewHeaderFooterView *)xl_dequeueReusableHeaderFooterView:(NSString *)reuseIdentifier {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}
/// 注册 cell
/// ReuseIdentifier: **CellClass.xl_identifier**
- (void)xl_registerForCell:(Class)CellClass {
    [self registerClass:CellClass forCellReuseIdentifier:CellClass.xl_identifier];
}

/// 注册 header or footer
/// ReuseIdentifier: **HeaderFooterClass.xl_identifier**
- (void)xl_registerForHeaderFooterView:(Class)HeaderFooterClass {
    [self registerClass:HeaderFooterClass forHeaderFooterViewReuseIdentifier:HeaderFooterClass.xl_identifier];
}

@end
