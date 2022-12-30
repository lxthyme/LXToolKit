//
//  LXLoginVM.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/5/25.
//  Copyright © 2022 lxthyme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
NS_ASSUME_NONNULL_BEGIN

@interface LXLoginVM : NSObject {
}
@property(nonatomic, copy)NSDictionary *f_result;

@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *pwdConfirm;
@property(nonatomic, assign)BOOL isLoginEnabled;

// @property(nonatomic, strong)RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
