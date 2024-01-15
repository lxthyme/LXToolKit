//
//  LXDJCommentCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DJCommentType) {
    DJCommentType0,
    DJCommentType1,
    DJCommentType2,
    DJCommentType3,
    DJCommentType4,
    DJCommentType5,
    DJCommentType6,
    DJCommentType7,
    DJCommentType8,
    DJCommentType9,
    DJCommentType10,
    DJCommentType11,
    DJCommentType12,
    DJCommentType13,
    DJCommentType14,
    DJCommentType15,
    DJCommentType16,
    DJCommentType17,
    DJCommentType18,
};

@interface LXDJCommentCell: LXBaseTableViewCell {
}

- (void)dataFill:(DJCommentType)type;

@end

NS_ASSUME_NONNULL_END
