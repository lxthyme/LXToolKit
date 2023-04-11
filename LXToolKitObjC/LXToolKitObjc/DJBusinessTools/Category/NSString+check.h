//
//  NSString+check.h
//  DJBusinessTools
//
//  Created by bl_osd on 2022/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (check)

/// 1、用户输入编辑非（汉字、数字、英文字母、_和- 字符）时，展示提示信息。
- (BOOL)checkTextIsValidForBuildingNo;
/// 1、用户输入编辑非（汉字、数字、英文字母）时，展示提示信息。
- (BOOL)checkTextIsValidForName;

@end

NS_ASSUME_NONNULL_END
