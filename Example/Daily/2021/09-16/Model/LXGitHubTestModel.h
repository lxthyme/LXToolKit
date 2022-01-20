//
//  LXGitHubTestModel.h
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXGitHubTestModel : MTLModel<MTLJSONSerializing> {
}
@property (readonly, nonatomic, copy) NSString *name;
@property (readonly, nonatomic, strong) NSDate *createdAt;

@property (readonly, nonatomic, assign) BOOL meUser;
//@property (readonly, nonatomic, strong) XYHelper *helper;

+ (void)test;

@end

NS_ASSUME_NONNULL_END
