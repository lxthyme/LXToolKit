//
//  LXGitHubTestModel.m
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXGitHubTestModel.h"

@interface LXGitHubTestModel() {
}

@end

@implementation LXGitHubTestModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"name": @"name",
        @"createdAt": @"created_at"
    };
}
+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate:value];
    }];
}
//+ (NSSet *)propertyKeys {
//    <#code#>
//}
#pragma mark -
#pragma mark - 👀Public Actions
+ (void)test {
    NSError *error = nil;
//    XYUser *user = [MTLJSONAdapter modelOfClass:XYUser.class fromJSONDictionary:JSONDictionary error:&error];
    NSDictionary *JSONDictionary = @{
        @"name": @"john",
        @"created_at": @"2013-07-02 16:40:00",
        @"plan": @"lite"
    };

    LXGitHubTestModel *user = [MTLJSONAdapter modelOfClass:LXGitHubTestModel.class fromJSONDictionary:JSONDictionary error:&error];

    if(!error) {
        NSLog(@"user: %@", user);
    } else {
        NSLog(@"error: %@", error);
    }
}

#pragma mark -
#pragma mark - 🔐Private Actions
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}
@end
