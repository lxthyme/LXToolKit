//
//  LXProxy.m
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/14.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LXProxy.h"

@implementation LXProxy

- (instancetype)initWithTarget:(id)target {
    self.target = target;
    return self;
}

+ (instancetype)weakProxyWithTarget:(id)target {
    return [[LXProxy alloc]initWithTarget:target];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (self.target && [self.target respondsToSelector:sel]) {
        return [self.target methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL aSelector = [invocation selector];
    if(self.target && [self.target respondsToSelector:aSelector]) {
        [invocation invokeWithTarget:self.target];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
