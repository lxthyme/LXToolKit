//
//  DJModuleClassifyO2OCell.h
//  DJTest
//
//  Created by lxthyme on 2024/1/31.
//
#import <UIKit/UIKit.h>
#import <DJBusinessModule/DJClassifyQuicklyO2OVC.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJModuleClassifyO2OCell: DJBaseTableViewCell {
}
@property(nonatomic, strong)DJClassifyQuicklyO2OVC *classifyO2OVC;

- (void)dataFill:(DJJSCateSlideModel *)quicklyModel;

@end

NS_ASSUME_NONNULL_END
