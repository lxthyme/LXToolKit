//
//  LXDJCommentPictureCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/11.
//
#import <UIKit/UIKit.h>

#define kLXDJCommentPictureCellWidth 80.f

NS_ASSUME_NONNULL_BEGIN

@interface LXDJCommentPictureCell: LXBaseCollectionViewCell {
}

- (void)dataFill:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
