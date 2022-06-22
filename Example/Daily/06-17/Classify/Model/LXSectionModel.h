//
//  LXSectionModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSectionItemModel : LXBaseModel {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *icon;

@end

@interface LXSectionModel : LXBaseModel {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSArray<LXSectionItemModel *> *itemList;

@end

@interface LXSubCategoryModel : LXBaseModel {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSArray<LXSectionModel *> *sectionList;

@end

@interface LXCategoryModel : LXBaseModel {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, assign)JXCategoryTitleImageType imageType;
@property(nonatomic, copy)NSString *imageNames;
@property(nonatomic, copy)NSString *selectedImageNames;
@property(nonatomic, strong)NSArray<LXSubCategoryModel *> *subCategoryList;

@end

NS_ASSUME_NONNULL_END
