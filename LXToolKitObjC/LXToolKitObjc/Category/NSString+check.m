//
//  NSString+check.m
//  DJBusinessTools
//
//  Created by bl_osd on 2022/9/1.
//

#import "NSString+check.h"

@implementation NSString (check)

- (BOOL)checkTextIsValidForBuildingNo {
    NSString *regex =@"^[a-zA-Z0-9\\u4e00-\\u9fa5_-]*$";
    NSPredicate *textPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [textPredicate evaluateWithObject:self];
    return isMatch;
}

- (BOOL)checkTextIsValidForName {
    NSString *regex =@"^[a-zA-Z0-9\\u4e00-\\u9fa5]*$";
    NSPredicate *textPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [textPredicate evaluateWithObject:self];
    return isMatch;
}

@end
