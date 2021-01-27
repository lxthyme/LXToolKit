//
//  main.m
//  LXMaJiaObjc
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *arguments = [[NSProcessInfo processInfo] arguments];
        if (!arguments || arguments.count <= 1) {
            printf("缺少工程目录参数\n");
            return 1;
        }
        if (arguments.count <= 2) {
            printf("缺少任务参数 -spamCodeOut or -handleXcassets or -deleteComments\n");
            return 1;
        }

        BOOL isDirectory = NO;
        NSString *outDirString = nil;
        NSArray<NSString *> *ignoreDirNames = nil;
        BOOL needHandleXcassets = NO;
        BOOL needDeleteComments = NO;
        NSString *oldProjectName = nil;
        NSString *newProjectName = nil;
        NSString *projectFilePath = nil;
        NSString *oldClassNamePrefix = nil;
        NSString *newClassNamePrefix = nil;

        NSFileManager *fm = [NSFileManager defaultManager];
        for (NSInteger i = 1; i < arguments.count; i++) {
            NSString *argument = arguments[i];
            if (i == 1) {
                gSourceCodeDir = argument;
                if (![fm fileExistsAtPath:gSourceCodeDir isDirectory:&isDirectory]) {
                    printf("%s不存在\n", [gSourceCodeDir UTF8String]);
                    return 1;
                }
                if (!isDirectory) {
                    printf("%s不是目录\n", [gSourceCodeDir UTF8String]);
                    return 1;
                }
                continue;
            }

            if ([argument isEqualToString:@"-handleXcassets"]) {
                needHandleXcassets = YES;
                continue;
            }
            if ([argument isEqualToString:@"-deleteComments"]) {
                needDeleteComments = YES;
                continue;
            }
            if ([argument isEqualToString:@"-modifyProjectName"]) {
                NSString *string = arguments[++i];
                NSArray<NSString *> *names = [string componentsSeparatedByString:@">"];
                if (names.count < 2) {
                    printf("修改工程名参数错误。参数示例：CCApp>DDApp，传入参数：%s\n", string.UTF8String);
                    return 1;
                }
                oldProjectName = names[0];
                newProjectName = names[1];
                if (oldProjectName.length <= 0 || newProjectName.length <= 0) {
                    printf("修改工程名参数错误。参数示例：CCApp>DDApp，传入参数：%s\n", string.UTF8String);
                    return 1;
                }
                continue;
            }
            if ([argument isEqualToString:@"-modifyClassNamePrefix"]) {
                NSString *string = arguments[++i];
                projectFilePath = [string stringByAppendingPathComponent:@"project.pbxproj"];
                if (![fm fileExistsAtPath:string isDirectory:&isDirectory] || !isDirectory
                    || ![fm fileExistsAtPath:projectFilePath isDirectory:&isDirectory] || isDirectory) {
                    printf("修改类名前缀的工程文件参数错误。%s", string.UTF8String);
                    return 1;
                }

                string = arguments[++i];
                NSArray<NSString *> *names = [string componentsSeparatedByString:@">"];
                if (names.count < 2) {
                    printf("修改类名前缀参数错误。参数示例：CC>DD，传入参数：%s\n", string.UTF8String);
                    return 1;
                }
                oldClassNamePrefix = names[0];
                newClassNamePrefix = names[1];
                if (oldClassNamePrefix.length <= 0 || newClassNamePrefix.length <= 0) {
                    printf("修改类名前缀参数错误。参数示例：CC>DD，传入参数：%s\n", string.UTF8String);
                    return 1;
                }
                continue;
            }
            if ([argument isEqualToString:@"-spamCodeOut"]) {
                outDirString = arguments[++i];
                if ([fm fileExistsAtPath:outDirString isDirectory:&isDirectory]) {
                    if (!isDirectory) {
                        printf("%s 已存在但不是文件夹，需要传入一个输出文件夹目录\n", [outDirString UTF8String]);
                        return 1;
                    }
                } else {
                    NSError *error = nil;
                    if (![fm createDirectoryAtPath:outDirString withIntermediateDirectories:YES attributes:nil error:&error]) {
                        printf("创建输出目录失败，请确认 -spamCodeOut 之后接的是一个“输出文件夹目录”参数，错误信息如下：\n传入的输出文件夹目录：%s\n%s\n", [outDirString UTF8String], [error.localizedDescription UTF8String]);
                        return 1;
                    }
                }

                NSString *newClassOutDirString = [outDirString stringByAppendingPathComponent:kNewClassDirName];
                if ([fm fileExistsAtPath:newClassOutDirString isDirectory:&isDirectory]) {
                    if (!isDirectory) {
                        printf("%s 已存在但不是文件夹\n", [newClassOutDirString UTF8String]);
                        return 1;
                    }
                } else {
                    NSError *error = nil;
                    if (![fm createDirectoryAtPath:newClassOutDirString withIntermediateDirectories:YES attributes:nil error:&error]) {
                        printf("创建输出目录 %s 失败", [newClassOutDirString UTF8String]);
                        return 1;
                    }
                }

                i++;
                if (i < arguments.count) {
                    gOutParameterName = arguments[i];
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]+" options:0 error:nil];
                    if ([regex numberOfMatchesInString:gOutParameterName options:0 range:NSMakeRange(0, gOutParameterName.length)] <= 0) {
                        printf("缺少垃圾代码参数名，或参数名\"%s\"不合法(需要字母开头)\n", [gOutParameterName UTF8String]);
                        return 1;
                    }
                } else {
                    printf("缺少垃圾代码参数名，参数名需要根在输出目录后面\n");
                    return 1;
                }

                i++;
                if (i < arguments.count) {
                    gSpamCodeFuncationCallName = arguments[i];
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]+" options:0 error:nil];
                    if ([regex numberOfMatchesInString:gSpamCodeFuncationCallName options:0 range:NSMakeRange(0, gSpamCodeFuncationCallName.length)] <= 0) {
                        printf("缺少垃圾代码函数调用名，或参数名\"%s\"不合法(需要字母开头)\n", [gSpamCodeFuncationCallName UTF8String]);
                        return 1;
                    }
                }

                i++;
                if (i < arguments.count) {
                    gNewClassFuncationCallName = arguments[i];
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]+" options:0 error:nil];
                    if ([regex numberOfMatchesInString:gNewClassFuncationCallName options:0 range:NSMakeRange(0, gNewClassFuncationCallName.length)] <= 0) {
                        printf("缺少 NewClass 代码函数调用名，或参数名\"%s\"不合法(需要字母开头)\n", [gNewClassFuncationCallName UTF8String]);
                        return 1;
                    }
                }
                continue;
            }
            if ([argument isEqualToString:@"-ignoreDirNames"]) {
                ignoreDirNames = [arguments[++i] componentsSeparatedByString:@","];
                continue;
            }
        }

        if (needHandleXcassets) {
            @autoreleasepool {
                handleXcassetsFiles(gSourceCodeDir);
            }
            printf("修改 Xcassets 中的图片名称完成\n");
        }
        if (needDeleteComments) {
            @autoreleasepool {
                deleteComments(gSourceCodeDir, ignoreDirNames);
            }
            printf("删除注释和空行完成\n");
        }
        if (oldProjectName && newProjectName) {
            @autoreleasepool {
                NSString *dir = gSourceCodeDir.stringByDeletingLastPathComponent;
                modifyProjectName(dir, oldProjectName, newProjectName);
            }
            printf("修改工程名完成\n");
        }
        if (oldClassNamePrefix && newClassNamePrefix) {
            printf("开始修改类名前缀...\n");
            @autoreleasepool {
                // 打开工程文件
                NSError *error = nil;
                NSMutableString *projectContent = [NSMutableString stringWithContentsOfFile:projectFilePath encoding:NSUTF8StringEncoding error:&error];
                if (error) {
                    printf("打开工程文件 %s 失败：%s\n", projectFilePath.UTF8String, error.localizedDescription.UTF8String);
                    return 1;
                }

                modifyClassNamePrefix(projectContent, gSourceCodeDir, ignoreDirNames, oldClassNamePrefix, newClassNamePrefix);

                [projectContent writeToFile:projectFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            printf("修改类名前缀完成\n");
        }
        if (outDirString) {
            NSMutableString *categoryCallImportString = [NSMutableString string];
            NSMutableString *categoryCallFuncString = [NSMutableString string];
            NSMutableString *newClassCallImportString = [NSMutableString string];
            NSMutableString *newClassCallFuncString = [NSMutableString string];

            recursiveDirectory(gSourceCodeDir, ignoreDirNames, ^(NSString *mFilePath) {
                @autoreleasepool {
                    generateSpamCodeFile(outDirString, mFilePath, GSCSourceTypeClass, categoryCallImportString, categoryCallFuncString, newClassCallImportString, newClassCallFuncString);
                    generateSpamCodeFile(outDirString, mFilePath, GSCSourceTypeCategory, categoryCallImportString, categoryCallFuncString, newClassCallImportString, newClassCallFuncString);
                }
            }, ^(NSString *swiftFilePath) {
                @autoreleasepool {
                    generateSwiftSpamCodeFile(outDirString, swiftFilePath);
                }
            });

            NSString *fileName = [gOutParameterName stringByAppendingString:@"CallHeader.h"];
            NSString *fileContent = [NSString stringWithFormat:@"%@\n%@return ret;\n}", categoryCallImportString, categoryCallFuncString];
            [fileContent writeToFile:[outDirString stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];

            fileName = [kNewClassDirName stringByAppendingString:@"CallHeader.h"];
            fileContent = [NSString stringWithFormat:@"%@\n%@return ret;\n}", newClassCallImportString, newClassCallFuncString];
            [fileContent writeToFile:[[outDirString stringByAppendingPathComponent:kNewClassDirName] stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];

            printf("生成垃圾代码完成\n");
        }
    }
    return 0;
}
