//
//  LXDJCommentTagCell.h
//  LXToolKitObjC_Example
//
//  Created by lxthyme on 2023/8/12.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXDJCommentTagCell: UICollectionViewCell {
}

- (void)dataFill:(NSString *)title;

- (CGFloat)calcCellWidth;

@end

NS_ASSUME_NONNULL_END
