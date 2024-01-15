//
//  LXDJZitiRuleTipModel.h
//  DJBusinessModule
//
//  Created by bl_osd on 2022/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXDJZitiRuleTipItemModel : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *value;

@end

@interface LXDJZitiRuleTipModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<LXDJZitiRuleTipItemModel *> *ruleLt;

@property (nonatomic, assign) BOOL checked;

@end

NS_ASSUME_NONNULL_END
