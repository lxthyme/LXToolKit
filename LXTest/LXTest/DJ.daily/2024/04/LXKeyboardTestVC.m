//
//  LXKeyboardTestVC.m
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2024/4/22.
//
#import "LXKeyboardTestVC.h"

#import <Masonry/Masonry.h>
#import <DJBusinessModule/DJCommonActionSheetView.h>

@interface LXKeyboardTestVC() {
}
@property(nonatomic, strong)UIButton *btnShowAlert;
@property(nonatomic, strong)UIButton *btnShowInVC;
@property(nonatomic, strong)UIView *wrapperView;
@property(nonatomic, strong)UITextView *tvContent;
@property(nonatomic, strong)DJCommonActionSheetView *sheetView;

@end

@implementation LXKeyboardTestVC
- (void)dealloc {
    NSLog(@"🎷DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // NSLog(@"🛠viewWillAppear: %@", NSStringFromClass([self class]));
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // NSLog(@"🛠viewDidAppear: %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    // NSLog(@"🛠viewWillDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    // NSLog(@"🛠viewDidDisappear: %@", NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.

    [self prepareUI];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)btnShowAlertClick:(UIButton *)sender {
    [self changeToAlert:YES];
    // [self.sheetView showWith:self.wrapperView];
    [self.sheetView showWith:self.wrapperView parentView:self.view];
}
- (void)btnShowInVCClick:(UIButton *)sender {
    [self changeToAlert:NO];
}
- (void)changeToAlert:(BOOL)isAlert {
    if(isAlert) {
        [self.wrapperView removeFromSuperview];
    } else {
        [self.view addSubview:self.wrapperView];
        [self.wrapperView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20.f);
            make.right.bottom.equalTo(@-20.f);
        }];
    }
}


#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // navigationItem.title = @"";

    [self.wrapperView addSubview:self.tvContent];
    // [self.view addSubview:self.wrapperView];
    [self.view addSubview:self.btnShowAlert];
    [self.view addSubview:self.btnShowInVC];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    // MASAttachKeys(<#...#>)
    // [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.left.equalTo(@20.f);
    //     make.right.bottom.equalTo(@-20.f);
    // }];
    [self.tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@200.f);
        make.edges.equalTo(@0.f);
    }];
    [self.btnShowAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0.f);
    }];
    [self.btnShowInVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnShowAlert.mas_bottom).offset(20.f);
        make.centerX.equalTo(@0.f);
    }];
}

#pragma mark Lazy Property
- (UIView *)wrapperView {
    if(!_wrapperView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        _wrapperView = v;
    }
    return _wrapperView;
}
- (DJCommonActionSheetView *)sheetView {
    if(!_sheetView){
        DJCommonActionSheetView *v = [[DJCommonActionSheetView alloc]init];
        _sheetView = v;
    }
    return _sheetView;
}
- (UITextView *)tvContent {
    if(!_tvContent){// <#UITextViewDelegate#>
        UITextView *tv = [[UITextView alloc]init];
        // tv.editable = NO;
        // tv.scrollEnabled = NO;
        tv.textColor = [UIColor blackColor];
        tv.font = [UIFont systemFontOfSize:15];
        tv.returnKeyType = UIReturnKeyDone;
        tv.keyboardType = UIKeyboardTypeDefault;
        tv.textAlignment = NSTextAlignmentLeft;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        tv.layer.borderWidth = 1.f;
        tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // tv.textContainer.maximumNumberOfLines = 0;
        // tv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        // tv.contentInset = UIEdgeInsetsZero;
        // tv.textContainerInset = UIEdgeInsetsZero;
        CGFloat padding = tv.textContainer.lineFragmentPadding;
        tv.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
        _tvContent = tv;
    }
    return _tvContent;
}
- (UIButton *)btnShowAlert {
    if(!_btnShowAlert){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor cyanColor];
        btn.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);

        [btn setTitle:@"show alert" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnShowAlertClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnShowAlert = btn;
    }
    return _btnShowAlert;
}
- (UIButton *)btnShowInVC {
    if(!_btnShowInVC){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor cyanColor];
        btn.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);

        [btn setTitle:@"show in VC" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnShowInVCClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnShowInVC = btn;
    }
    return _btnShowInVC;
}
@end
