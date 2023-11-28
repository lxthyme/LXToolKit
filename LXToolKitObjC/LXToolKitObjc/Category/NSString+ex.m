//
//  NSString+ex.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/8/7.
//

#import "NSString+ex.h"
// #import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>

@implementation NSString (ex)

- (BOOL)isEmpty {
    return !self ||
    [self isEqual:[NSNull null]] ||
    (([self isKindOfClass:[NSString class]] &&
      [@"" isEqualToString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) ||
     [@"\"null\"" isEqualToString:self] ||
     [@"null" isEqualToString:self]);
}

/// 计算NSString中英文字符串的字符长度。ios 中一个汉字算2字符数
- (int)xl_charNumber {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}
- (NSString *)xl_substringTo:(NSInteger)length {
    NSString *str = self;
    NSString *tmp = self;
    if([self xl_charNumber] > length) {
        for (int i = str.length; i > 0; i--) {
            tmp = [str substringToIndex:i];
            if ([tmp xl_charNumber] <= length) {
                str = [tmp stringByAppendingString:@"..."];
                break;
            }
        }
    }
    return tmp;
}

/// 正则匹配返回符合要求的字符串 数组
/// @param regexStr 正则表达式
/// @return 符合要求的字符串 数组 (按(),分级,正常0)
- (NSArray *)matchWithRegex:(NSString *)regexStr {
    if(self.isEmpty) {
        return @[self];
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    //match: 所有匹配到的字符,根据() 包含级
    NSArray * matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];

    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            NSString *component = [self substringWithRange:[match rangeAtIndex:i]];
            [array addObject:component];
        }
    }
    return array;
}

@end
