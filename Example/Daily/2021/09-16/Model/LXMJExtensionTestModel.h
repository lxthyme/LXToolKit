//
//  LXMJExtensionTestModel.h
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface LXMJExtensionTestModel : NSObject {
}
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;

+ (void)test;

@end

NS_ASSUME_NONNULL_END
