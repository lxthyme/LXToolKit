//
//  NSString+ex.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ex)

- (BOOL)isEmpty;

/// 截取字符串(中文按照两个字符计算)
/// @param length 长度
- (NSString *)xl_substringTo:(NSInteger)length;

/// 正则匹配返回符合要求的字符串 数组
/// @param regexStr 正则表达式
/// @return 符合要求的字符串 数组 (按(),分级,正常0)
- (NSArray *)matchWithRegex:(NSString *)regexStr;

@end

NS_ASSUME_NONNULL_END
