//
//  LXLoggerObjc.h
//  LXToolKit
//
//  Created by lxthyme on 2022/3/21.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#ifndef LXLoggerObjc_h
#define LXLoggerObjc_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#define dlogError(frmt, ...)   DDLogError(frmt, ##__VA_ARGS__)
#define dlogWarn(frmt, ...)    DDLogWarn(frmt, ##__VA_ARGS__)
#define dlogInfo(frmt, ...)    DDLogInfo(frmt, ##__VA_ARGS__)
#define dlogDebug(frmt, ...)   DDLogDebug(frmt, ##__VA_ARGS__)
#define dlogVerbose(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)
#define dlog dlogDebug

#define xlogError(frmt, ...)   DDLogError(frmt, ##__VA_ARGS__)
#define xlogWarn(frmt, ...)    DDLogWarn(frmt, ##__VA_ARGS__)
#define xlogInfo(frmt, ...)    DDLogInfo(frmt, ##__VA_ARGS__)
#define xlogDebug(frmt, ...)   DDLogDebug(frmt, ##__VA_ARGS__)
#define xlogVerbose(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)

#define fmtVar(arg) (@""#arg)

// static func xlog() {
// static func xlog(msg: @autoclosure () -> String) {
    // xlogError(@"%@: %@", fmtVar(msg), msg);
// }

void xlog(NSString *frmt, ...) {
    NSMutableString *log = [NSMutableString string];
    va_list arg_list;
    va_start(arg_list, frmt);
    id arg = nil;
    arg = va_arg(arg_list, id);
    while (arg) {
        [log appendFormat:@"%@: %@\n", fmtVar(arg), arg];

        arg = va_arg(arg_list, id);
    }
    va_end(arg_list);

    NSLog(@"%@", log);

    // va_start(args, frmt);
    // NSLogv(frmt, args);
    // va_end(args);
}

// static func xlog(msg: @autoclosure () -> String) {
    // xlogError(@"%@: %@", fmtVar(msg), msg);
// }


// static func xlog2(frmt: String) {
    // xlogError(@"%@:", fmtVar(msg));
// }

#endif /* LXLoggerObjc_h */
