//
//  LXResolveTestObj.m
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "LXResolveTestObj.h"
#import <objc/message.h>

#import "LXPerson.h"

@implementation LXResolveTestObj

- (void)testRealized {
    NSLog(@"-----testRealized-----");
}
//-(void)testUnRealized {}

#pragma mark - 🍺快速转发流程
#pragma mark - 1st
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"[resolveInstanceMethod] - %@", NSStringFromSelector(sel));
    if(sel == @selector(testUnRealized)) {
//        Method method = class_getInstanceMethod(self, @selector(testRealized));
//        const char *types = method_getTypeEncoding(method);
//        IMP imp = class_getMethodImplementation(self, @selector(testRealized));
//        return class_addMethod(self, sel, imp, types);
    }
    return [super resolveInstanceMethod:sel];
//    return YES;
}

#pragma mark - 2rd
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"[forwardingTargetForSelector] - %@", NSStringFromSelector(aSelector));
    if(aSelector == @selector(testUnRealized)) {
//        return [LXPerson alloc];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 🍺慢速转发流程
#pragma mark -
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"[methodSignatureForSelector] - %@", NSStringFromSelector(aSelector));
    if(aSelector == @selector(testUnRealized)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = [anInvocation selector];
    NSLog(@"[forwardInvocation] - %@", NSStringFromSelector(aSelector));
    if([[LXPerson alloc] respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:[LXPerson alloc]];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end
