//
//  LX0527VC.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/27.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LX0527VC.h"

@interface LX0527VC() {
}
@property(nonatomic, strong)UITextField *tfUsername;
@property(nonatomic, strong)UITextField *tfPwd;
@property(nonatomic, strong)UITextField *tfPwdConfirm;
@property(nonatomic, strong)UIButton *btnLogin;

@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *pwdConfirm;
@property(nonatomic, assign)BOOL createEnabled;
@property(nonatomic, strong)RACCommand *loginCommand;
@end

@implementation LX0527VC
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

    [self prepareUI];

    // [self racTest1];
    // [self ractTest_RACSequence];
    [self racTest_RACSignal];
}

#pragma mark -
#pragma mark - 🌎LoadData

#pragma mark -
#pragma mark - 👀Public Actions

#pragma mark -
#pragma mark - 🔐Private Actions
- (void)racTest1 {
    [[RACObserve(self, username)
      filter:^BOOL(NSString *_Nullable value) {
        return [value hasPrefix:@"l"];
    }]
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"x: %@", x);
    }];
    RAC(self, createEnabled) = [RACSignal
                                combineLatest:@[RACObserve(self, pwd), RACObserve(self, pwdConfirm)]
                                reduce:^(NSString *pwd, NSString *pwdConfirm){
        return @([pwdConfirm isEqualToString:pwd]);
    }];
    self.btnLogin.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"button was pressed");
        return [RACSignal empty];
    }];
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *_Nullable loginSignal) {
        [self.view endEditing:YES];
        [loginSignal subscribeCompleted:^{
            NSLog(@"Logged in successful!");
        }];
    }];
    self.btnLogin.rac_command = self.loginCommand;
}

- (void)ractTest_RACSequence {
    NSArray *strings = @[@"A", @"B", @"C", @"D", @"E", @"F"];
    RACSequence *sequence = [strings.rac_sequence map:^id _Nullable(NSString *_Nullable value) {
        NSLog(@"[1]v: %@", value);
        return [value stringByAppendingString:@"_"];
    }];
    // id x1 = sequence.head;
    // id x2 = sequence.tail.head;

    RACSequence *derivedSequence = [sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"[2]v: %@", value);
        return [@"_" stringByAppendingString:value];
    }];

    id x3 = derivedSequence.tail.head;
    // id x4 = derivedSequence.head;

}
- (void)racTest_RACSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"-->dealloc");
        }];
    }];
#if DEBUG
    [signal setNameWithFormat:@"rac-%@", RACDescription(self)];
#endif

    [[signal deliverOnMainThread]
     subscribeNext:^(id  _Nullable x) {
            NSLog(@"-->[1]: %@: %@", x, [NSThread currentThread]);
    }];
    [[signal deliverOn:[RACScheduler scheduler]]
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"-->[2]: %@: %@", x, [NSThread currentThread]);
    }];
    [[signal deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityHigh name:@"com.lx.bl"]]
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"-->[3]: %@: %@", x, [NSThread currentThread]);
    }];
    [[signal deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault name:@"com.lx.bl2"]]
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"-->[4]: %@: %@", x, [NSThread currentThread]);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"-->[5]: %@: %@", x, [NSThread currentThread]);
    }];
}

#pragma mark -
#pragma mark - 🍺UI Prepare & Masonry
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
        [tf setPlaceholder:@""];
        // [tf setSecureTextEntry:<#BOOL#>];
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setKeyboardType:UIKeyboardTypeDefault];
        _tfPwdConfirm = tf;
    }
    return _tfPwdConfirm;
}
- (UIButton *)btnLogin {
    if(!_btnLogin){
        // 初始化一个 Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];

        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateDisabled];

        _btnLogin = btn;
    }
    return _btnLogin;
}
@end
