//
//  LXDJSearchResultHeaderView.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/4/18.
//
#import <UIKit/UIKit.h>
#import <LXToolKitObjC/LXBaseCollectionReusableView.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DJSearchResultHeaderStyle) {
    DJSearchResultHeaderStyleNone,
    DJSearchResultHeaderStyleRefresh,
    DJSearchResultHeaderStyleDelete
};

@interface LXDJSearchResultHeaderView: LXBaseCollectionReusableView {
}
@property(nonatomic, copy)void (^actionBlock)(DJSearchResultHeaderStyle style);

- (void)dataFill:(NSString *)title style:(DJSearchResultHeaderStyle)style;

@end

NS_ASSUME_NONNULL_END
