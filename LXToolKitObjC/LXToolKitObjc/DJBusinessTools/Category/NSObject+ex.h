//
//  NSObject+ex.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/9/13.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ex)

+ (NSString *)xl_typeName;
- (NSString *)xl_typeName;

+ (NSString *)xl_identifier;

@end

NS_ASSUME_NONNULL_END
