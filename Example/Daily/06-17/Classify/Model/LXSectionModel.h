//
//  LXSectionModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSectionItemModel : NSObject {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *icon;

@end

@interface LXSectionModel : NSObject {
}
@property(nonatomic, copy)NSString *sectionTitle;
@property(nonatomic, strong)NSArray<LXSectionItemModel *> *itemList;

@end

@interface LXCategoryModel : NSObject {
}
@property(nonatomic, copy)NSString *categoryTitle;
@property(nonatomic, strong)NSArray<LXSectionModel *> *sectionList;

@end

NS_ASSUME_NONNULL_END
