//
//  LXBaseTableViewCell.m
//  LXToolKitObjc
//
//  Created by lxthyme on 2022/6/22.
//
#import "LXBaseTableViewCell.h"

@interface LXBaseTableViewCell() {
}

@end

@implementation LXBaseTableViewCell
- (void)dealloc {
    NSLog(@"🛠DEALLOC: %@", NSStringFromClass([self class]));
}

@end
