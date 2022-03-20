//
//  LXLoggerObjc.h
//  LXToolKit
//
//  Created by lxthyme on 2022/3/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#ifndef LXLoggerObjc_h
#define LXLoggerObjc_h

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

// static func xlog(msg: @autoclosure () -> String) {
//     xlogError(@"%@: %@", fmtVar(msg), msg);
// }


#endif /* LXLoggerObjc_h */
