//
//  DJZitiRuleTipModel.m
//  DJBusinessModule
//
//  Created by bl_osd on 2022/11/17.
//

#import "DJZitiRuleTipModel.h"
#import <YYModel/NSObject+YYModel.h>

@implementation DJZitiRuleTipItemModel

@end

@implementation DJZitiRuleTipModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{
        @"ruleLt" : [DJZitiRuleTipItemModel class],
    };
}

@end
