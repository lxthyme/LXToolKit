//
//  LXGoodsInfoListModel.h
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/22.
//  Copyright © 2022 lxthyme. All rights reserved.
//
#import "LXBaseModel.h"
@class LXGoodsInfoModel;
@class DJGoodsPopinfosList;
@class DJRule;

typedef NS_ENUM(NSInteger, DJGoodsRuleType) {
    DJGoodsRuleTypeUnknown,
    /// 新人价
    DJGoodsRuleType12,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXGoodsInfoListModel: LXBaseModel {
}
@property (nonatomic, assign)NSInteger totalCount;
@property (nonatomic, assign)NSInteger totalPage;
@property (nonatomic, assign)NSInteger pageNum;
@property (nonatomic, assign)NSInteger pageSize;
@property (nonatomic, copy)NSArray<LXGoodsInfoModel *> *goodsInfoList;
@property (nonatomic, copy)NSString *f_categoryId;

@end

@interface LXGoodsInfoModel: LXBaseModel {
}
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *goodsType;
@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, copy)NSString *salesName;
@property (nonatomic, copy)NSString *brandSid;
@property (nonatomic, copy)NSString *basePrice;
@property (nonatomic, copy)NSString *salePrice;
@property (nonatomic, copy)NSString *saleStockSum;
@property (nonatomic, copy)NSString *saleStockStatus;
@property (nonatomic, copy)NSString *limitBuyPersonSum;
@property (nonatomic, strong)NSDictionary *pic;
@property (nonatomic, copy)NSString *marketOn;
@property (nonatomic, copy)NSString *priceType;
@property (nonatomic, copy)NSArray *popinfosList;
@property (nonatomic, copy)NSArray *previewList;
@property (nonatomic, copy)NSArray *xgList;
@property (nonatomic, assign)NSInteger goodsScore;
@property (nonatomic, assign)NSInteger secondaryScore;
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, assign)NSInteger pageSortField;
@property (nonatomic, assign)NSInteger rowNum;
@property (nonatomic, assign)NSInteger minBuyQuan;

@property (nonatomic, copy)NSString *subtitle233;
@property (nonatomic, copy)NSString *tdType233;
@property (nonatomic, copy)NSString *tdLable233;
@property (nonatomic, assign)NSInteger num233;
@property (nonatomic, copy)NSString *icon233;
@property(nonatomic, copy)NSAttributedString *f_titleAttributeString;
@property(nonatomic, copy)NSAttributedString *f_subtitleAttributeString;
/// RACSequence<DJGoodsPopinfosList *>
@property (nonatomic, copy)RACSequence *f_popinfosList;
@property(nonatomic, assign)CGFloat f_cellHeight;
@property(nonatomic, assign)CGFloat f_titleMaxWidth;

@end

@interface DJGoodsPopinfosList: LXBaseModel {
}
@property (nonatomic, copy)NSArray<DJRule *> *rules;
@property (nonatomic, copy)NSString *activityType;
@property (nonatomic, copy)NSString *memo;
@property (nonatomic, copy)NSString *labelDesc;
@property (nonatomic, copy)NSString *goodsDetSid;
@property (nonatomic, copy)NSString *popDES;
@property (nonatomic, copy)NSString *ruleid;
@property (nonatomic, assign)DJGoodsRuleType ruletype;
@property (nonatomic, copy)NSString *ruleName;
@property (nonatomic, copy)NSString *activityDesc;
@property (nonatomic, copy)NSString *activityId;
@property (nonatomic, copy)NSString *shopid;
@property (nonatomic, copy)NSString *sLabel;
@property (nonatomic, copy)NSString *mLabel;
@property (nonatomic, copy)NSString *discountType;
@property (nonatomic, copy)NSString *conditionType;
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

@interface DJRule: LXBaseModel {
}
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *identifier;
@end

NS_ASSUME_NONNULL_END

