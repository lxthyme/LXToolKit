//
//  LXMaJia+modifyClassPrefix.m
//  LXMaJiaObjc
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXMaJia+modifyClassPrefix.h"

@implementation LXMaJia (modifyClassPrefix)

#pragma mark - 修改类名前缀

void modifyFilesClassName(NSString *sourceCodeDir, NSString *oldClassName, NSString *newClassName) {
    // 文件内容 Const > DDConst (h,m,swift,xib,storyboard)
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:sourceCodeDir error:nil];
    BOOL isDirectory;
    for (NSString *filePath in files) {
        NSString *path = [sourceCodeDir stringByAppendingPathComponent:filePath];
        if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) {
            modifyFilesClassName(path, oldClassName, newClassName);
            continue;
        }

        NSString *fileName = filePath.lastPathComponent;
        if ([fileName hasSuffix:@".h"] || [fileName hasSuffix:@".m"] || [fileName hasSuffix:@".pch"] || [fileName hasSuffix:@".swift"] || [fileName hasSuffix:@".xib"] || [fileName hasSuffix:@".storyboard"]) {

            NSError *error = nil;
            NSMutableString *fileContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                printf("打开文件 %s 失败：%s\n", path.UTF8String, error.localizedDescription.UTF8String);
                abort();
            }

            NSString *regularExpression = [NSString stringWithFormat:@"\\b%@\\b", oldClassName];
            BOOL isChanged = regularReplacement(fileContent, regularExpression, newClassName);
            if (!isChanged) continue;
            error = nil;
            [fileContent writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                printf("保存文件 %s 失败：%s\n", path.UTF8String, error.localizedDescription.UTF8String);
                abort();
            }
        }
    }
}

void modifyClassNamePrefix(NSMutableString *projectContent, NSString *sourceCodeDir, NSArray<NSString *> *ignoreDirNames, NSString *oldName, NSString *newName) {
    NSFileManager *fm = [NSFileManager defaultManager];

    // 遍历源代码文件 h 与 m 配对，swift
    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:sourceCodeDir error:nil];
    BOOL isDirectory;
    for (NSString *filePath in files) {
        NSString *path = [sourceCodeDir stringByAppendingPathComponent:filePath];
        if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) {
            if (![ignoreDirNames containsObject:filePath]) {
                modifyClassNamePrefix(projectContent, path, ignoreDirNames, oldName, newName);
            }
            continue;
        }

        NSString *fileName = filePath.lastPathComponent.stringByDeletingPathExtension;
        NSString *fileExtension = filePath.pathExtension;
        NSString *newClassName;
        if ([fileName hasPrefix:oldName]) {
            newClassName = [newName stringByAppendingString:[fileName substringFromIndex:oldName.length]];
        } else {
            //处理是category的情况。当是category时，修改+号后面的类名前缀
            NSString *oldNamePlus = [NSString stringWithFormat:@"+%@",oldName];
            if ([fileName containsString:oldNamePlus]) {
                NSMutableString *fileNameStr = [[NSMutableString alloc] initWithString:fileName];
                [fileNameStr replaceCharactersInRange:[fileName rangeOfString:oldNamePlus] withString:[NSString stringWithFormat:@"+%@",newName]];
                newClassName = fileNameStr;
            }else{
                newClassName = [newName stringByAppendingString:fileName];
            }
        }

        // 文件名 Const.ext > DDConst.ext
        if ([fileExtension isEqualToString:@"h"]) {
            NSString *mFileName = [fileName stringByAppendingPathExtension:@"m"];
            if ([files containsObject:mFileName]) {
                NSString *oldFilePath = [[sourceCodeDir stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"h"];
                NSString *newFilePath = [[sourceCodeDir stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"h"];
                renameFile(oldFilePath, newFilePath);
                oldFilePath = [[sourceCodeDir stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"m"];
                newFilePath = [[sourceCodeDir stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"m"];
                renameFile(oldFilePath, newFilePath);
                oldFilePath = [[sourceCodeDir stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"xib"];
                if ([fm fileExistsAtPath:oldFilePath]) {
                    newFilePath = [[sourceCodeDir stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"xib"];
                    renameFile(oldFilePath, newFilePath);
                }

                @autoreleasepool {
                    modifyFilesClassName(gSourceCodeDir, fileName, newClassName);
                }
            } else {
                continue;
            }
        } else if ([fileExtension isEqualToString:@"swift"]) {
            NSString *oldFilePath = [[sourceCodeDir stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"swift"];
            NSString *newFilePath = [[sourceCodeDir stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"swift"];
            renameFile(oldFilePath, newFilePath);
            oldFilePath = [[sourceCodeDir stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"xib"];
            if ([fm fileExistsAtPath:oldFilePath]) {
                newFilePath = [[sourceCodeDir stringByAppendingPathComponent:newClassName] stringByAppendingPathExtension:@"xib"];
                renameFile(oldFilePath, newFilePath);
            }

            @autoreleasepool {
                modifyFilesClassName(gSourceCodeDir, fileName.stringByDeletingPathExtension, newClassName);
            }
        } else {
            continue;
        }

        // 修改工程文件中的文件名
        NSString *regularExpression = [NSString stringWithFormat:@"\\b%@\\b", fileName];
        regularReplacement(projectContent, regularExpression, newClassName);
    }
}

@end
