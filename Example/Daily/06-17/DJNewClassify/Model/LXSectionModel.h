//
//  LXSectionModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/6/19.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import <DJBusinessTools/LXBaseModel.h>

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DJGoodsItemModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface LXSectionItemModel : LXBaseModel {
}
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSAttributedString *f_titleAttributeString;
@property(nonatomic, copy)NSString *subtitle;
@property(nonatomic, copy)NSAttributedString *f_subtitleAttributeString;
/// RACSequence<DJGoodsPopinfosList *>
@property (nonatomic, copy)RACSequence *f_popinfosList;
@property(nonatomic, assign)BOOL is24H;
@property(nonatomic, assign)NSInteger num;
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, strong)DJGoodsItemModel *goodsItem;
@property(nonatomic, assign)CGFloat f_cellHeight;
@property(nonatomic, assign)CGFloat f_titleMaxWidth;

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
@property(nonatomic, copy)NSString *imageNames;
@property(nonatomic, copy)NSString *selectedImageNames;
@property(nonatomic, strong)NSArray<LXSubCategoryModel *> *subCategoryList;

@end

NS_ASSUME_NONNULL_END
