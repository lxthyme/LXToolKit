//
//  handle + SampleCode.swift
//  MaJia
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

//#pragma mark - 生成垃圾代码

//void recursiveDirectory(NSString *directory, NSArray<NSString *> *ignoreDirNames, void(^handleMFile)(NSString *mFilePath), void(^handleSwiftFile)(NSString *swiftFilePath)) {
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:directory error:nil];
//    BOOL isDirectory;
//    for (NSString *filePath in files) {
//        NSString *path = [directory stringByAppendingPathComponent:filePath];
//        if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) {
//            if (![ignoreDirNames containsObject:filePath]) {
//                recursiveDirectory(path, nil, handleMFile, handleSwiftFile);
//            }
//            continue;
//        }
//        NSString *fileName = filePath.lastPathComponent;
//        if ([fileName hasSuffix:@".h"]) {
//            fileName = [fileName stringByDeletingPathExtension];
//
//            NSString *mFileName = [fileName stringByAppendingPathExtension:@"m"];
//            if ([files containsObject:mFileName]) {
//                handleMFile([directory stringByAppendingPathComponent:mFileName]);
//            }
//        } else if ([fileName hasSuffix:@".swift"]) {
//            handleSwiftFile([directory stringByAppendingPathComponent:fileName]);
//        }
//    }
//}

//NSString * getImportString(NSString *hFileContent, NSString *mFileContent) {
//    NSMutableString *ret = [NSMutableString string];
//
//    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^ *[@#]import *.+" options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnicodeWordBoundaries error:nil];
//
//    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:hFileContent options:0 range:NSMakeRange(0, hFileContent.length)];
//    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *importRow = [hFileContent substringWithRange:[obj rangeAtIndex:0]];
//        [ret appendString:importRow];
//        [ret appendString:@"\n"];
//    }];
//
//    matches = [expression matchesInString:mFileContent options:0 range:NSMakeRange(0, mFileContent.length)];
//    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *importRow = [mFileContent substringWithRange:[obj rangeAtIndex:0]];
//        [ret appendString:importRow];
//        [ret appendString:@"\n"];
//    }];
//
//    return ret;
//}

//static NSString *const kHClassFileTemplate = @"\
//%@\n\
//@interface %@ (%@)\n\
//%@\n\
//@end\n";

//static NSString *const kMClassFileTemplate = @"\
//#import \"%@+%@.h\"\n\
//@implementation %@ (%@)\n\
//%@\n\
//@end\n";

//static NSString *const kHNewClassFileTemplate = @"\
//#import <Foundation/Foundation.h>\n\
//@interface %@: NSObject\n\
//%@\n\
//@end\n";

//static NSString *const kMNewClassFileTemplate = @"\
//#import \"%@.h\"\n\
//@implementation %@\n\
//%@\n\
//@end\n";

//void generateSpamCodeFile(NSString *outDirectory, NSString *mFilePath, GSCSourceType type, NSMutableString *categoryCallImportString, NSMutableString *categoryCallFuncString, NSMutableString *newClassCallImportString, NSMutableString *newClassCallFuncString) {
//    NSString *mFileContent = [NSString stringWithContentsOfFile:mFilePath encoding:NSUTF8StringEncoding error:nil];
//    NSString *regexStr;
//    switch (type) {
//        case GSCSourceTypeClass:
//            regexStr = @" *@implementation +(\\w+)[^(]*\\n(?:.|\\n)+?@end";
//            break;
//        case GSCSourceTypeCategory:
//            regexStr = @" *@implementation *(\\w+) *\\((\\w+)\\)(?:.|\\n)+?@end";
//            break;
//    }
//
//    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
//    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:mFileContent options:0 range:NSMakeRange(0, mFileContent.length)];
//    if (matches.count <= 0) return;
//
//    NSString *hFilePath = [mFilePath.stringByDeletingPathExtension stringByAppendingPathExtension:@"h"];
//    NSString *hFileContent = [NSString stringWithContentsOfFile:hFilePath encoding:NSUTF8StringEncoding error:nil];
//
//    // 准备要引入的文件
//    NSString *fileImportStrings = getImportString(hFileContent, mFileContent);
//
//    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull impResult, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *className = [mFileContent substringWithRange:[impResult rangeAtIndex:1]];
//        NSString *categoryName = nil;
//        NSString *newClassName = [NSString stringWithFormat:@"%@%@%@", gOutParameterName, className, randomLetter()];
//        if (impResult.numberOfRanges >= 3) {
//            categoryName = [mFileContent substringWithRange:[impResult rangeAtIndex:2]];
//        }
//
//        if (type == GSCSourceTypeClass) {
//            // 如果该类型没有公开，只在 .m 文件中使用，则不处理
//            NSString *regexStr = [NSString stringWithFormat:@"\\b%@\\b", className];
//            NSRange range = [hFileContent rangeOfString:regexStr options:NSRegularExpressionSearch];
//            if (range.location == NSNotFound) {
//                return;
//            }
//        }
//
//        // 查找方法
//        NSString *implementation = [mFileContent substringWithRange:impResult.range];
//        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^ *([-+])[^)]+\\)([^;{]+)" options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionUseUnicodeWordBoundaries error:nil];
//        NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:implementation options:0 range:NSMakeRange(0, implementation.length)];
//        if (matches.count <= 0) return;
//
//        // 新类 h m 垃圾文件内容
//        NSMutableString *hNewClassFileMethodsString = [NSMutableString string];
//        NSMutableString *mNewClassFileMethodsString = [NSMutableString string];
//
//        // 生成 h m 垃圾文件内容
//        NSMutableString *hFileMethodsString = [NSMutableString string];
//        NSMutableString *mFileMethodsString = [NSMutableString string];
//        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull matche, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *symbol = @"+";//[implementation substringWithRange:[matche rangeAtIndex:1]];
//            NSString *methodName = [[implementation substringWithRange:[matche rangeAtIndex:2]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            NSString *newClassMethodName = nil;
//            NSString *methodCallName = nil;
//            NSString *newClassMethodCallName = nil;
//            if ([methodName containsString:@":"]) {
//                // 去掉参数，生成无参数的新名称
//                NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"\\b([\\w]+) *:" options:0 error:nil];
//                NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:methodName options:0 range:NSMakeRange(0, methodName.length)];
//                if (matches.count > 0) {
//                    NSMutableString *newMethodName = [NSMutableString string];
//                    NSMutableString *newClassNewMethodName = [NSMutableString string];
//                    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull matche, NSUInteger idx, BOOL * _Nonnull stop) {
//                        NSString *str = [methodName substringWithRange:[matche rangeAtIndex:1]];
//                        [newMethodName appendString:(newMethodName.length > 0 ? str.capitalizedString : str)];
//                        [newClassNewMethodName appendFormat:@"%@%@", randomLetter(), str.capitalizedString];
//                    }];
//                    methodCallName = [NSString stringWithFormat:@"%@%@", newMethodName, gOutParameterName.capitalizedString];
//                    [newMethodName appendFormat:@"%@:(NSInteger)%@", gOutParameterName.capitalizedString, gOutParameterName];
//                    methodName = newMethodName;
//
//                    newClassMethodCallName = [NSString stringWithFormat:@"%@", newClassNewMethodName];
//                    newClassMethodName = [NSString stringWithFormat:@"%@:(NSInteger)%@", newClassMethodCallName, gOutParameterName];
//                } else {
//                    methodName = [methodName stringByAppendingFormat:@" %@:(NSInteger)%@", gOutParameterName, gOutParameterName];
//                }
//            } else {
//                newClassMethodCallName = [NSString stringWithFormat:@"%@%@", randomLetter(), methodName];
//                newClassMethodName = [NSString stringWithFormat:@"%@:(NSInteger)%@", newClassMethodCallName, gOutParameterName];
//
//                methodCallName = [NSString stringWithFormat:@"%@%@", methodName, gOutParameterName.capitalizedString];
//                methodName = [methodName stringByAppendingFormat:@"%@:(NSInteger)%@", gOutParameterName.capitalizedString, gOutParameterName];
//            }
//
//            [hFileMethodsString appendFormat:@"%@ (BOOL)%@;\n", symbol, methodName];
//
//            [mFileMethodsString appendFormat:@"%@ (BOOL)%@ {\n", symbol, methodName];
//            [mFileMethodsString appendFormat:@"    return %@ %% %u == 0;\n", gOutParameterName, arc4random_uniform(50) + 1];
//            [mFileMethodsString appendString:@"}\n"];
//
//            if (methodCallName.length > 0) {
//                if (gSpamCodeFuncationCallName && categoryCallFuncString.length <= 0) {
//                    [categoryCallFuncString appendFormat:@"static inline NSInteger %@() {\nNSInteger ret = 0;\n", gSpamCodeFuncationCallName];
//                }
//                [categoryCallFuncString appendFormat:@"ret += [%@ %@:%u] ? 1 : 0;\n", className, methodCallName, arc4random_uniform(100)];
//            }
//
//
//            if (newClassMethodName.length > 0) {
//                [hNewClassFileMethodsString appendFormat:@"%@ (BOOL)%@;\n", symbol, newClassMethodName];
//
//                [mNewClassFileMethodsString appendFormat:@"%@ (BOOL)%@ {\n", symbol, newClassMethodName];
//                [mNewClassFileMethodsString appendFormat:@"    return %@ %% %u == 0;\n", gOutParameterName, arc4random_uniform(50) + 1];
//                [mNewClassFileMethodsString appendString:@"}\n"];
//            }
//
//            if (newClassMethodCallName.length > 0) {
//                if (gNewClassFuncationCallName && newClassCallFuncString.length <= 0) {
//                    [newClassCallFuncString appendFormat:@"static inline NSInteger %@() {\nNSInteger ret = 0;\n", gNewClassFuncationCallName];
//                }
//                [newClassCallFuncString appendFormat:@"ret += [%@ %@:%u] ? 1 : 0;\n", newClassName, newClassMethodCallName, arc4random_uniform(100)];
//            }
//        }];
//
//        NSString *newCategoryName;
//        switch (type) {
//            case GSCSourceTypeClass:
//                newCategoryName = gOutParameterName.capitalizedString;
//                break;
//            case GSCSourceTypeCategory:
//                newCategoryName = [NSString stringWithFormat:@"%@%@", categoryName, gOutParameterName.capitalizedString];
//                break;
//        }
//
//        // category m
//        NSString *fileName = [NSString stringWithFormat:@"%@+%@.m", className, newCategoryName];
//        NSString *fileContent = [NSString stringWithFormat:kMClassFileTemplate, className, newCategoryName, className, newCategoryName, mFileMethodsString];
//        [fileContent writeToFile:[outDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        // category h
//        fileName = [NSString stringWithFormat:@"%@+%@.h", className, newCategoryName];
//        fileContent = [NSString stringWithFormat:kHClassFileTemplate, fileImportStrings, className, newCategoryName, hFileMethodsString];
//        [fileContent writeToFile:[outDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//        [categoryCallImportString appendFormat:@"#import \"%@\"\n", fileName];
//
//        // new class m
//        NSString *newOutDirectory = [outDirectory stringByAppendingPathComponent:kNewClassDirName];
//        fileName = [NSString stringWithFormat:@"%@.m", newClassName];
//        fileContent = [NSString stringWithFormat:kMNewClassFileTemplate, newClassName, newClassName, mNewClassFileMethodsString];
//        [fileContent writeToFile:[newOutDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        // new class h
//        fileName = [NSString stringWithFormat:@"%@.h", newClassName];
//        fileContent = [NSString stringWithFormat:kHNewClassFileTemplate, newClassName, hNewClassFileMethodsString];
//        [fileContent writeToFile:[newOutDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//        [newClassCallImportString appendFormat:@"#import \"%@\"\n", fileName];
//    }];
//}

//static NSString *const kSwiftFileTemplate = @"\
//%@\n\
//extension %@ {\n%@\
//}\n";

//static NSString *const kSwiftMethodTemplate = @"\
//    func %@%@(_ %@: String%@) {\n\
//        print(%@)\n\
//    }\n";

//void generateSwiftSpamCodeFile(NSString *outDirectory, NSString *swiftFilePath) {
//    NSString *swiftFileContent = [NSString stringWithContentsOfFile:swiftFilePath encoding:NSUTF8StringEncoding error:nil];
//
//    // 查找 class 声明
//    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@" *(class|struct) +(\\w+)[^{]+" options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
//    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:swiftFileContent options:0 range:NSMakeRange(0, swiftFileContent.length)];
//    if (matches.count <= 0) return;
//
//    NSString *fileImportStrings = getSwiftImportString(swiftFileContent);
//    __block NSInteger braceEndIndex = 0;
//    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull classResult, NSUInteger idx, BOOL * _Nonnull stop) {
//        // 已经处理到该 range 后面去了，过掉
//        NSInteger matchEndIndex = classResult.range.location + classResult.range.length;
//        if (matchEndIndex < braceEndIndex) return;
//        // 是 class 方法，过掉
//        NSString *fullMatchString = [swiftFileContent substringWithRange:classResult.range];
//        if ([fullMatchString containsString:@"("]) return;
//
//        NSRange braceRange = getOutermostCurlyBraceRange(swiftFileContent, '{', '}', matchEndIndex);
//        braceEndIndex = braceRange.location + braceRange.length;
//
//        // 查找方法
//        NSString *classContent = [swiftFileContent substringWithRange:braceRange];
//        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"func +([^(]+)\\([^{]+" options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
//        NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:classContent options:0 range:NSMakeRange(0, classContent.length)];
//        if (matches.count <= 0) return;
//
//        NSMutableString *methodsString = [NSMutableString string];
//        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull funcResult, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSRange funcNameRange = [funcResult rangeAtIndex:1];
//            NSString *funcName = [classContent substringWithRange:funcNameRange];
//            NSRange oldParameterRange = getOutermostCurlyBraceRange(classContent, '(', ')', funcNameRange.location + funcNameRange.length);
//            NSString *oldParameterName = [classContent substringWithRange:oldParameterRange];
//            oldParameterName = [oldParameterName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            if (oldParameterName.length > 0) {
//                oldParameterName = [@", " stringByAppendingString:oldParameterName];
//            }
//            if (![funcName containsString:@"<"] && ![funcName containsString:@">"]) {
//                funcName = [NSString stringWithFormat:@"%@%@", funcName, randomString(5)];
//                [methodsString appendFormat:kSwiftMethodTemplate, funcName, gOutParameterName.capitalizedString, gOutParameterName, oldParameterName, gOutParameterName];
//            } else {
//                NSLog(@"string contains `[` or `]` bla! funcName: %@", funcName);
//            }
//        }];
//        if (methodsString.length <= 0) return;
//
//        NSString *className = [swiftFileContent substringWithRange:[classResult rangeAtIndex:2]];
//
//        NSString *fileName = [NSString stringWithFormat:@"%@%@Ext.swift", className, gOutParameterName.capitalizedString];
//        NSString *filePath = [outDirectory stringByAppendingPathComponent:fileName];
//        NSString *fileContent = @"";
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//            fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//        }
//        fileContent = [fileContent stringByAppendingFormat:kSwiftFileTemplate, fileImportStrings, className, methodsString];
//        [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    }];
//}
