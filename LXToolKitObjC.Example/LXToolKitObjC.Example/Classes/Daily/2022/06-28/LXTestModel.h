//
//  LXTestModel.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2022/6/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <LXToolKitObjC/LXBaseModel.h>

NS_ASSUME_NONNULL_BEGIN
@interface LXTestModel: LXBaseModel {
    NSString *var1;
    NSString *var2;
    NSString *var3;
    NSString *var4;
    NSString *var5;
}
@property(nonatomic, copy)NSString *f_test1;
@property(nonatomic, copy)NSString *f_test2;
@property(nonatomic, copy)NSString *f_test3;
@property(nonatomic, copy)NSString *test4;
@property(nonatomic, copy)NSString *test5;

@property(nonatomic, copy)NSString *name1;
@property(nonatomic, copy)NSString *name2;
@property(nonatomic, copy)NSString *name3;
@property(nonatomic, copy)NSString *f_name4;
@property(nonatomic, copy)NSString *f_name5;

@end

NS_ASSUME_NONNULL_END
