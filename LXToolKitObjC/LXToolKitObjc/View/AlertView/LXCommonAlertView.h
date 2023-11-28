//
//  LXCommonAlertView.h
//  DJProductDetailView
//
//  Created by lxthyme on 2022/2/21.
//

#import <UIKit/UIKit.h>
// #import <MMPopupView/MMPopupView.h>
#import <LXToolKitObjC/LXButton.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^closeBtnBlock)(void);  //按钮Block

@interface LXCommonAlertView : UIView {
}
@property(nonatomic, strong)UIView *wrapperView;
/// logo
@property(nonatomic, strong)UIImageView *imgViewLogo;
/// 标题
@property(nonatomic, strong)UILabel *labTitle;
/// 内容
@property(nonatomic, strong)UILabel *labContent;
@property(nonatomic, strong)UIView *lineView;
/// 确认
@property(nonatomic, strong)UIButton *btnConfirm;
/// 取消
@property(nonatomic, strong)UIButton *btnCancel;
/// 关闭按钮
@property(nonatomic, strong)LXButton *btnClosed;

@property(nonatomic, strong)UIView *btnWrapperView;
@property(nonatomic, strong)UIStackView *btnWrapperStackView;
/// 是否正在展示
@property(nonatomic, assign)BOOL isShowing;
/// 点击确认按钮的回调
@property(nonatomic, copy)void (^dismissBlock)(void);

@property (nonatomic, copy) closeBtnBlock closeBtnBlock;

- (void)bringBtnCancelToFront;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
