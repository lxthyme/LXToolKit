//
//  LXLogger.h
//  DJBusinessTools
//
//  Created by lxthyme on 2022/2/24.
//

#ifndef LXLogger_h
#define LXLogger_h
#import <CocoaLumberjack/CocoaLumberjack.h>

#if DEBUG
    static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
    static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#ifdef DEBUG
#define dlogError(frmt, ...)    DDLogError(frmt, ##__VA_ARGS__)
#define dlogWarn(frmt, ...)     DDLogWarn(frmt, ##__VA_ARGS__)
#define dlogInfo(frmt, ...)     DDLogInfo(frmt, ##__VA_ARGS__)
#define dlog(frmt, ...)         DDLogDebug(frmt, ##__VA_ARGS__)
#define dlogDebug(frmt, ...)    DDLogDebug(frmt, ##__VA_ARGS__)
#define dlogVerbose(frmt, ...)  DDLogVerbose(frmt, ##__VA_ARGS__)
#else
#define dlogError(...)
#define dlogWarn(...)
#define dlogInfo(...)
#define dlog(...)
#define dlogDebug(...)
#define dlogVerbose(...)
#endif

#ifdef DEBUG
#define xlogError(frmt, ...)    DDLogError(frmt, ##__VA_ARGS__)
#define xlogWarn(frmt, ...)     DDLogWarn(frmt, ##__VA_ARGS__)
#define xlogInfo(frmt, ...)     DDLogInfo(frmt, ##__VA_ARGS__)
#define xlog(frmt, ...)         DDLogDebug(frmt, ##__VA_ARGS__)
#define xlogDebug(frmt, ...)    DDLogDebug(frmt, ##__VA_ARGS__)
#define xlogVerbose(frmt, ...)  DDLogVerbose(frmt, ##__VA_ARGS__)
#else
#define xlogError(...)
#define xlogWarn(...)
#define xlogInfo(...)
#define xlog(...)
#define xlogDebug(...)
#define xlogVerbose(...)
#endif


#ifdef DEBUG
/// 基类, 工具方法, 非业务相关 log
#define commonlog(frmt, ...)        DDLogDebug(frmt, ##__VA_ARGS__)
#else
#define commonlog(...)
#endif

#endif /* LXLogger_h */
