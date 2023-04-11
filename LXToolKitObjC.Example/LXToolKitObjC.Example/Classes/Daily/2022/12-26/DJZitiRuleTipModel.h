//
//  DJZitiRuleTipModel.h
//  DJBusinessModule
//
//  Created by bl_osd on 2022/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJZitiRuleTipItemModel : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *value;

@end

@interface DJZitiRuleTipModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<DJZitiRuleTipItemModel *> *ruleLt;

@property (nonatomic, assign) BOOL checked;

@end

NS_ASSUME_NONNULL_END
