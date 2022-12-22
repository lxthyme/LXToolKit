//
//  LXLoginVC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXLoginVC.h"
#import "LXLoginVM.h"
#import <Masonry/Masonry.h>
#import <LXToolKitObjc/LXButton.h>
// #import <LXToolKitObjc/LXButton.h>

@interface LXLoginVC() {
}
@property(nonatomic, strong)UITextField *tfUsername;
@property(nonatomic, strong)UITextField *tfPwd;
@property(nonatomic, strong)UITextField *tfPwdConfirm;
@property(nonatomic, strong)LXButton *btnLogin;
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;

@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *pwdConfirm;
@property(nonatomic, assign)BOOL createEnabled;
@property(nonatomic, strong)RACCommand *loginCommand;

@property(nonatomic, strong)LXLoginVM *vm;

@end

@implementation LXLoginVC
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

#pragma mark -
#pragma mark - 🛠Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"🛠viewDidLoad: %@", NSStringFromClass([self class]));
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.vm = [[LXLoginVM alloc]init];

    self.tfUsername.text = @"1";
    self.tfPwd.text = @"1";
    self.tfPwdConfirm.text = @"1";
    [self prepareUI];
    [self prepareVM];
    [self bindVM];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions
- (void)bindVM {

    RAC(self.btnLogin, enabled) = RACObserve(self.vm, isLoginEnabled);

    @weakify(self);
    [[[self.btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside]throttle:1.f]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        // [self.vm.loginCommand execute:nil];
        [self.view endEditing:YES];
    }];
    // [[self.vm.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
    //     @strongify(self)
    //     // if(x.boolValue) {
    //     //     [self.btnLogin startLoading];
    //     // } else {
    //     //     [self.btnLogin stopLoading];
    //     // }
    //     NSLog(@"-->X: %@-%@", x, self.vm.f_result);
    // }];
    // [self.vm.loginCommand.executionSignals subscribeNext:^(RACSignal *_Nullable signal) {
    //     @strongify(self);
    //     [[signal dematerialize] subscribeNext:^(id  _Nullable x) {
    //         NSLog(@"[2]Next-X: %@", x);
    //     } error:^(NSError * _Nullable error) {
    //         NSLog(@"[2]Error: %@", error);
    //     }];
    // }];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
- (void)prepareVM {
    @weakify(self)
    RAC(self.vm, username) = [self.tfUsername.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        if(value.length > 25) {
            self.tfUsername.text = [value substringToIndex:20];
        }
        return self.tfUsername.text;
    }];
    RAC(self.vm, pwd) = [self.tfPwd.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        if(value.length > 25) {
            self.tfPwd.text = [value substringToIndex:20];
        }
        return self.tfPwd.text;
    }];
    RAC(self.vm, pwdConfirm) = [self.tfPwdConfirm.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        if(value.length > 25) {
            self.tfPwdConfirm.text = [value substringToIndex:20];
        }
        return self.tfPwdConfirm.text;
    }];
}
- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tfUsername];
    [self.view addSubview:self.tfPwd];
    [self.view addSubview:self.tfPwdConfirm];
    [self.view addSubview:self.btnLogin];

    [self masonry];
}

#pragma mark Masonry
- (void)masonry {
    [self.tfUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100.f);
        make.left.equalTo(@20.f);
        make.right.equalTo(@(-20.f));
    }];
    [self.tfPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfUsername.mas_bottom).offset(10.f);
        make.left.right.equalTo(self.tfUsername);
    }];
    [self.tfPwdConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPwd.mas_bottom).offset(10.f);
        make.left.right.equalTo(self.tfUsername);
    }];
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPwdConfirm.mas_bottom).offset(20.f);
        make.left.right.equalTo(self.tfUsername);
        make.height.equalTo(@44.f);
    }];
}

#pragma mark Lazy Property
- (UITextField *)tfUsername {
    if(!_tfUsername){
        //<UITextFieldDelegate>
        UITextField *tf = [[UITextField alloc]init];
        [tf setFrame:CGRectZero];
        [tf setBackgroundColor:[UIColor whiteColor]];
        [tf setPlaceholder:@"请输入用户名..."];
        // [tf setSecureTextEntry:<#BOOL#>];
        tf.borderStyle = UITextBorderStyleBezel;
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setKeyboardType:UIKeyboardTypeDefault];
        _tfUsername = tf;
    }
    return _tfUsername;
}
- (UITextField *)tfPwd {
    if(!_tfPwd){
        //<UITextFieldDelegate>
        UITextField *tf = [[UITextField alloc]init];
        [tf setFrame:CGRectZero];
        [tf setBackgroundColor:[UIColor whiteColor]];
        [tf setPlaceholder:@"请输入密码..."];
        // [tf setSecureTextEntry:<#BOOL#>];
        tf.borderStyle = UITextBorderStyleBezel;
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setKeyboardType:UIKeyboardTypeDefault];
        _tfPwd = tf;
    }
    return _tfPwd;
}
- (UITextField *)tfPwdConfirm {
    if(!_tfPwdConfirm){
        //<UITextFieldDelegate>
        UITextField *tf = [[UITextField alloc]init];
        [tf setFrame:CGRectZero];
        [tf setBackgroundColor:[UIColor whiteColor]];
        [tf setPlaceholder:@"请重新输入密码..."];
        // [tf setSecureTextEntry:<#BOOL#>];
        tf.borderStyle = UITextBorderStyleBezel;
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setKeyboardType:UIKeyboardTypeDefault];
        _tfPwdConfirm = tf;
    }
    return _tfPwdConfirm;
}
- (LXButton *)btnLogin {
    if(!_btnLogin){
        // 初始化一个 Button
        LXButton *btn = [LXButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateDisabled];

        _btnLogin = btn;
    }
    return _btnLogin;
}
- (UIActivityIndicatorView *)indicatorView {
    if(!_indicatorView){
        UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView = v;
    }
    return _indicatorView;
}
@end
