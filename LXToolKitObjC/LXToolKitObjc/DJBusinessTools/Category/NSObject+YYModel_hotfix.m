//
//  NSObject+YYModel_hotfix.m
//  test
//
//  Created by lxthyme on 2022/9/26.
//

#import "NSObject+YYModel_hotfix.h"
#import <YYModel/YYModel.h>
// #import <objc/runtime.h>

static NSNumberFormatter *__fm;

@implementation NSObject (YYModel_hotfix)

+ (void)load {
    __fm = [[NSNumberFormatter alloc]init];
    __fm.maximumFractionDigits = 4;
    __fm.numberStyle = NSNumberFormatterDecimalStyle;
    [__fm setGroupingSeparator:@""];

    Method method1 = class_getInstanceMethod([self class], @selector(yy_modelSetWithDictionary:));
    Method method2 = class_getInstanceMethod([self class], @selector(xl_modelSetWithDictionary:));
    method_exchangeImplementations(method1, method2);
}
- (BOOL)xl_modelSetWithDictionary:(NSDictionary *)dic {
    if(![NSStringFromClass([self class]) hasPrefix:@"DJ"]) {
        return [self xl_modelSetWithDictionary:dic];
    }
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            NSNumber *num = (NSNumber *)obj;
            NSString *str = [__fm stringFromNumber:num];
            [mDictionary setValue:str forKey:key];
            if([key isEqualToString:@"showSalePrice"]) {
                NSLog(@"obj: %@\tstr: %@", obj, str);
            }
        } else {
            [mDictionary setValue:obj forKey:key];
        }
    }];
    return [self xl_modelSetWithDictionary:mDictionary];
}

@end
