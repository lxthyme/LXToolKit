//
//  DJCommentPictureCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import <UIKit/UIKit.h>

#define kDJCommentPictureCellWidth 80.f

NS_ASSUME_NONNULL_BEGIN

@interface DJCommentPictureCell: LXBaseCollectionViewCell {
}

- (void)dataFill:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
