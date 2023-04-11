//
//  LXBaseModel.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LXBaseModel() {
}

@end

@implementation LXBaseModel

#pragma mark -
#pragma mark - 🛠Life Cycle
// + (NSDictionary *)modelCustomPropertyMapper {
//     return @{};
// }
// + (NSDictionary *)modelContainerPropertyGenericClass {
//     return @{};
// }
/// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    YYClassInfo *a = [YYClassInfo classInfoWithClass:[self class]];
    return [a.propertyInfos.allKeys.rac_sequence filter:^BOOL(NSString *_Nullable key) {
        return [key hasPrefix:kIgnorePropertyPreffix];
    }].array;
}

/// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
// + (NSArray *)modelPropertyWhitelist {
//     return @[@"name1"];
// }

/// 当 JSON 转为 Model 完成后，该方法会被调用。
/// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
/// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return [self didFinishTransformFromDictionary];
}

/// 当 Model 转为 JSON 完成后，该方法会被调用。
/// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
/// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    return [self didFinishTransformToDictionary];
}

#pragma mark -
#pragma mark - 👀Public Actions
- (BOOL)didFinishTransformFromDictionary {
    return YES;
}
- (BOOL)didFinishTransformToDictionary {
    return YES;
}

#pragma mark -
#pragma mark - 🔐Private Actions

@end
