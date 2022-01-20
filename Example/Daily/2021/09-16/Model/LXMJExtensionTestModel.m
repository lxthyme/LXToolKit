//
//  LXMJExtensionTestModel.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXMJExtensionTestModel.h"

#import <MJExtension/MJExtension.h>

@interface LXMJExtensionTestModel() {
}

@end

@implementation LXMJExtensionTestModel

#pragma mark -
#pragma mark - 👀Public Actions
+ (void)test {
    NSDictionary *dict = @{
        @"name" : @"Jack",
        @"icon" : @"lufy.png",
        @"age" : @20,
        @"height" : @"1.55",
        @"money" : @100.9,
        @"sex" : @(SexFemale),
        @"gay" : @"true"
    //   @"gay" : @"1"
    //   @"gay" : @"NO"
    };

    // JSON -> User
    LXMJExtensionTestModel *user = [LXMJExtensionTestModel mj_objectWithKeyValues:dict];

    NSLog(@"name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
    // name=Jack, icon=lufy.png, age=20, height=1.550000, money=100.9, sex=1
    NSLog(@"user: %@", @[
        user.mj_JSONData,
        user.mj_JSONObject,
        user.mj_keyValues,
        user.mj_JSONString
          ]);
    NSLog(@"MJExtension: %@", @[
//        LXMJExtensionTestModel.mj_error
//        LXMJExtensionTestModel.mj_numberLocale,
//        LXMJExtensionTestModel.mj_allowedPropertyNames,
//        LXMJExtensionTestModel.mj_ignoredPropertyNames,
//        LXMJExtensionTestModel.mj_objectClassInArray,
//        LXMJExtensionTestModel.mj_totalAllowedPropertyNames,
//        LXMJExtensionTestModel.mj_totalIgnoredPropertyNames,
//        LXMJExtensionTestModel.mj_allowedCodingPropertyNames,
//        LXMJExtensionTestModel.mj_ignoredCodingPropertyNames,
//        LXMJExtensionTestModel.mj_replacedKeyFromPropertyName,
//        LXMJExtensionTestModel.mj_totalAllowedCodingPropertyNames,
//        LXMJExtensionTestModel.mj_totalIgnoredCodingPropertyNames
                              ]);
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
