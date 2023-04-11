//
//  LXMaJia+common.h
//  LXMaJiaObjc
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXMaJia.h"

NS_ASSUME_NONNULL_BEGIN

NSString *gOutParameterName = nil;
NSString *gSpamCodeFuncationCallName = nil;
NSString *gNewClassFuncationCallName = nil;
NSString *gSourceCodeDir = nil;
static NSString * const kNewClassDirName = @"NewClass";

@interface LXMaJia (common)

typedef NS_ENUM(NSInteger, GSCSourceType) {
    GSCSourceTypeClass,
    GSCSourceTypeCategory,
};

void recursiveDirectory(NSString *directory, NSArray<NSString *> *ignoreDirNames, void(^handleMFile)(NSString *mFilePath), void(^handleSwiftFile)(NSString *swiftFilePath));
void generateSpamCodeFile(NSString *outDirectory, NSString *mFilePath, GSCSourceType type, NSMutableString *categoryCallImportString, NSMutableString *categoryCallFuncString, NSMutableString *newClassCallImportString, NSMutableString *newClassCallFuncString);
void generateSwiftSpamCodeFile(NSString *outDirectory, NSString *swiftFilePath);
NSString *randomString(NSInteger length);
void handleXcassetsFiles(NSString *directory);
void deleteComments(NSString *directory, NSArray<NSString *> *ignoreDirNames);
void modifyProjectName(NSString *projectDir, NSString *oldName, NSString *newName);
void modifyClassNamePrefix(NSMutableString *projectContent, NSString *sourceCodeDir, NSArray<NSString *> *ignoreDirNames, NSString *oldName, NSString *newName);

@end

NS_ASSUME_NONNULL_END
