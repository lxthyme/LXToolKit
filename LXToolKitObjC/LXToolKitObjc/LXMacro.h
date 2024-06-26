//
//  LXMacro.h
//  LXToolKitObjC
//
//  Created by lxthyme on 2022/5/27.
//

#ifndef LXMacro_h
#define LXMacro_h

#ifndef WEAKSELF
#define WEAKSELF(self)  __weak __typeof(&*self)weakSelf = self;
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#endif

#ifndef kHPercentage
#define kHPercentage(a) (SCREEN_HEIGHT * ((a) / 667.00))
#endif

#ifndef kWPercentage
#define kWPercentage(a) (SCREEN_WIDTH *((a) / 375))
#endif

#define kBOOLString(__bool__) ((__bool__) ? @"YES" : @"NO")
#define kCGPointString(__point__) [NSString stringWithFormat:@"(x: %f, y: %f)", __point__.x, __point__.y]
#define kCGSizeString(__size__) [NSString stringWithFormat:@"(width: %f, height: %f)", __size__.width, __size__.height]
#define kCGRectString(__rect__) [NSString stringWithFormat:@"(x: %f, y: %f, width: %f, height: %f)", __rect__.origin.x, __rect__.origin.y, __rect__.size.width, __rect__.size.height]

/// 像素对齐
#define kFixed0_5 ([UIScreen mainScreen].scale >= 3 ? 0.75f : 0.5f)

#endif /* LXMacro_h */
