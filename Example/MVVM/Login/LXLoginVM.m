//
//  LXLoginVM.m
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import "LXLoginVM.h"
#import <BLRawAPIManager/DJNewShopCarSubmitCartAPIManager.h>

@interface LXLoginVM() {
}
@property(nonatomic, strong)DJNewShopCarSubmitCartAPIManager *djNewShopCarSubmitCartAPIManager;

@end

@implementation LXLoginVM
- (instancetype)init {
    if(self = [super init]) {
        [self prepareVM];
    }
    return self;
}
#pragma mark -
#pragma mark - 👀Public Actions
- (void)prepareVM {
    RAC(self, isLoginEnabled) = [[RACSignal combineLatest:@[
        RACObserve(self, username),
        RACObserve(self, pwd),
        RACObserve(self, pwdConfirm)]] map:^id _Nullable(RACTuple * _Nullable value) {
        RACTupleUnpack(NSString *username, NSString *pwd, NSString *pwdConfirm) = value;
        BOOL success = username.length > 0 &&
        pwd.length > 0 &&
        pwdConfirm.length > 0 &&
        [pwd isEqualToString:pwdConfirm];
        NSLog(@"(%@, %@, %@): %@", username, pwd, pwdConfirm, kBOOLString(success));
        return @(success);

    }];
}

#pragma mark -
#pragma mark - 🔐Private Actions

#pragma mark -
#pragma mark Lazy Property
- (RACCommand *)loginCommand {
    if(!_loginCommand){
        @weakify(self)
        RACCommand *cmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            self.djNewShopCarSubmitCartAPIManager.finalParamsToCall = @{};
            return [[[self.djNewShopCarSubmitCartAPIManager rac_requestSignal] doNext:^(CTAPIBaseManager *_Nullable apiManager) {
                self.f_result = apiManager.response.content;
            }] materialize];
        }];
        _loginCommand = cmd;
    }
    return _loginCommand;
}

- (DJNewShopCarSubmitCartAPIManager *)djNewShopCarSubmitCartAPIManager {
    if(!_djNewShopCarSubmitCartAPIManager){
        _djNewShopCarSubmitCartAPIManager = [[DJNewShopCarSubmitCartAPIManager alloc]init];
    }
    return _djNewShopCarSubmitCartAPIManager;
}
@end
