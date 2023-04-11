//
//  UIImage+xl.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/20.
//

#import "UIImage+xl.h"

@implementation UIImage (xl)

+ (UIImage *)xl_imageNamed:(NSString *)name {
    UIImage *img = nil;
    if(name.length > 0) {
        img = [UIImage imageNamed:name];
        if(!img) {
            NSLog(@"-->xl_imageNamed not found: %@", name);
        }
    }
    return img;
}

@end
