//
//  DJModuleQuickHomeView.h
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import <UIKit/UIKit.h>
#import <JXPageListView/JXPageListView.h>
#import <DJBusinessModule/DJClassifyO2OVC.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJModuleQuickHomeView: DJBaseView<JXPageListViewListDelegate> {
}
@property(nonatomic, strong)DJClassifyO2OVC *classifyO2OVC;

- (instancetype)initWithRefreshBlock:(void (^)(void))refreshPageListView;

@end

NS_ASSUME_NONNULL_END
