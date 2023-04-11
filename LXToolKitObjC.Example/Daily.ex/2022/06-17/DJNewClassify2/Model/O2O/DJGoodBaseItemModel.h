//
//  DJGoodBaseItemModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/28.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
#import "DJClassifyMacro.h"
@class DJGoodItemPopinfosList;
@class DJGoodItemRule;

NS_ASSUME_NONNULL_BEGIN

@interface DJGoodBaseItemModel: LXBaseModel {
}
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *goodsType;
@property (nonatomic, copy)NSString *basePrice;
@property (nonatomic, copy)NSString *salePrice;
@property (nonatomic, copy)NSString *saleStockSum;
@property (nonatomic, copy)NSString *saleStockStatus;
@property (nonatomic, copy)NSString *limitBuyPersonSum;
@property (nonatomic, copy)NSString *marketOn;
@property (nonatomic, assign)NSInteger priceType;
@property (nonatomic, copy)NSArray<DJGoodItemPopinfosList *> *popinfosList;
@property (nonatomic, copy)NSArray *previewList;
@property (nonatomic, copy)NSArray *xgList;
@property (nonatomic, assign)NSInteger minBuyQuan;

// @property (nonatomic, copy)NSString *subtitle233;
// @property (nonatomic, copy)NSString *tdType233;
// @property (nonatomic, copy)NSString *tdLable233;
@property (nonatomic, assign)NSInteger num233;
// @property (nonatomic, copy)NSString *icon233;
@property(nonatomic, copy)NSAttributedString *f_titleAttributeString;
@property(nonatomic, copy)NSAttributedString *f_subtitleAttributeString;
/// RACSequence<DJGoodItemPopinfosList *>
@property (nonatomic, copy)RACSequence *f_popinfosList;
@property(nonatomic, assign)CGFloat f_cellHeight;
@property(nonatomic, assign)CGFloat f_titleMaxWidth;
@property(nonatomic, assign)DJClassifyGoodItemType f_itemType;

- (NSString *)xl_goodsName;

@end

@interface DJGoodItemPopinfosList: LXBaseModel {

}
@property (nonatomic, copy)NSArray<DJGoodItemRule *> *rules;
@property (nonatomic, copy)NSString *activityType;
@property (nonatomic, copy)NSString *memo;
@property (nonatomic, copy)NSString *labelDesc;
@property (nonatomic, copy)NSString *goodsDetSid;
@property (nonatomic, assign)NSString *popDes;
@property (nonatomic, copy)NSString *ruleid;
@property (nonatomic, copy)NSString *discountType;
@property (nonatomic, copy)NSString *conditionType;
@property (nonatomic, assign)DJRuleType ruletype;
@property (nonatomic, copy)NSString *ruleName;
@property (nonatomic, copy)NSString *activityDesc;
@property (nonatomic, copy)NSString *activityId;
@property (nonatomic, copy)NSString *shopid;
@property (nonatomic, copy)NSString *sLabel;
@property (nonatomic, copy)NSString *mLabel;
@property (nonatomic, copy)NSString *activityTag;
@property (nonatomic, copy)NSString *discountAmount;
@property (nonatomic, copy)NSString *memberLimit;
@property (nonatomic, copy)NSString *orderLimit;
@property (nonatomic, copy)NSString *lLabel;
/// 1: plus会员券
@property (nonatomic, copy)NSString *buyMember;

@property (nonatomic, strong)UIFont *f_textFont;
@property (nonatomic, strong)UIColor *f_textColor;
@property (nonatomic, strong)UIColor *f_backgroundColor;
@property (nonatomic, assign)CGFloat f_cornerRadius;
@property (nonatomic, assign)CGFloat f_borderWidth;
@property (nonatomic, strong)UIColor *f_borderColor;
@property (nonatomic, copy)NSString *f_text;
@property (nonatomic, strong)NSAttributedString *f_textAttributeString;
@property (nonatomic, assign)CGRect f_textRect;

- (void)makeTextAttribute;

@end

@interface DJGoodItemRule: LXBaseModel {
}
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *t_id;

@end

NS_ASSUME_NONNULL_END
