//
//  LXBaseModel.h
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseObject.h"
#import <YYModel/YYModel.h>

/// 自定义属性的前缀
/// 拥有该前缀的属性, 在转换 model 的过程中会被忽略掉
static NSString * const _Nonnull kIgnorePropertyPreffix = @"f_";

NS_ASSUME_NONNULL_BEGIN

@interface LXBaseModel : NSObject {
}

/// 当 JSON 转为 Model 完成后，该方法会被「自动」调用。
/// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
/// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)didFinishTransformFromDictionary;

/// 当 Model 转为 JSON 完成后，该方法会被「自动」调用。
/// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
/// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)didFinishTransformToDictionary;

@end

NS_ASSUME_NONNULL_END
