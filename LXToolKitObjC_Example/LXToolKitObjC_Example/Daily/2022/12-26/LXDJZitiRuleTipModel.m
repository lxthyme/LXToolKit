//
//  LXDJZitiRuleTipModel.m
//  DJBusinessModule
//
//  Created by bl_osd on 2022/11/17.
//

#import "LXDJZitiRuleTipModel.h"
#import <YYModel/NSObject+YYModel.h>

@implementation LXDJZitiRuleTipItemModel

@end

@implementation LXDJZitiRuleTipModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
        @"ruleLt" : [LXDJZitiRuleTipItemModel class],
    };
}

@end
