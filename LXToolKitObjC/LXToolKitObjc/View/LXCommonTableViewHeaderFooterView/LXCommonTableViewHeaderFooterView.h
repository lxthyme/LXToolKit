//
//  LXCommonTableViewHeaderFooterView.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXCommonTableViewHeaderFooterView : UITableViewHeaderFooterView {
}
/// 水平间隔
@property(nonatomic, assign)CGFloat hPadding;
@property(nonatomic, strong)UILabel *labTitle;

@end

NS_ASSUME_NONNULL_END
