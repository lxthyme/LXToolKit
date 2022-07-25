//
//  LXMacro.h
//  LXToolKitObjc
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

#endif /* LXMacro_h */
