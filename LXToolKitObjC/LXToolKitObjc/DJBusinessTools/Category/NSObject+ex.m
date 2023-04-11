//
//  NSObject+ex.m
//  DJBusinessTools
//
//  Created by lxthyme on 2022/9/13.
//

#import "NSObject+ex.h"

@implementation NSObject (ex)

+ (NSString *)xl_typeName {
    return NSStringFromClass([self class]);
}
- (NSString *)xl_typeName {
    return NSStringFromClass([self class]);
}

+ (NSString *)xl_identifier {
    return self.xl_typeName;
}
@end
