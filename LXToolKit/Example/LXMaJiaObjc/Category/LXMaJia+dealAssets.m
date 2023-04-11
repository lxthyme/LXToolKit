//
//  LXMaJia+dealAssets.m
//  LXMaJiaObjc
//
//  Created by LXThyme Jason on 2021/1/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "LXMaJia+dealAssets.h"

@implementation LXMaJia (dealAssets)

#pragma mark - 处理 Xcassets 中的图片文件

void handleXcassetsFiles(NSString *directory) {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:directory error:nil];
    BOOL isDirectory;
    for (NSString *fileName in files) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        if ([fm fileExistsAtPath:filePath isDirectory:&isDirectory] && isDirectory) {
            handleXcassetsFiles(filePath);
            continue;
        }
        if (![fileName isEqualToString:@"Contents.json"]) continue;
        NSString *contentsDirectoryName = filePath.stringByDeletingLastPathComponent.lastPathComponent;
        if (![contentsDirectoryName hasSuffix:@".imageset"]) continue;

        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (!fileContent) continue;

        NSMutableArray<NSString *> *processedImageFileNameArray = @[].mutableCopy;
        static NSString * const regexStr = @"\"filename\" *: *\"(.*)?\"";
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionUseUnicodeWordBoundaries error:nil];
        NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:fileContent options:0 range:NSMakeRange(0, fileContent.length)];
        while (matches.count > 0) {
            NSInteger i = 0;
            NSString *imageFileName = nil;
            do {
                if (i >= matches.count) {
                    i = -1;
                    break;
                }
                imageFileName = [fileContent substringWithRange:[matches[i] rangeAtIndex:1]];
                i++;
            } while ([processedImageFileNameArray containsObject:imageFileName]);
            if (i < 0) break;

            NSString *imageFilePath = [filePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:imageFileName];
            if ([fm fileExistsAtPath:imageFilePath]) {
                NSString *newImageFileName = [randomString(10) stringByAppendingPathExtension:imageFileName.pathExtension];
                NSString *newImageFilePath = [filePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:newImageFileName];
                while ([fm fileExistsAtPath:newImageFileName]) {
                    newImageFileName = [randomString(10) stringByAppendingPathExtension:imageFileName.pathExtension];
                    newImageFilePath = [filePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:newImageFileName];
                }

                renameFile(imageFilePath, newImageFilePath);

                fileContent = [fileContent stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"\"%@\"", imageFileName]
                                                                     withString:[NSString stringWithFormat:@"\"%@\"", newImageFileName]];
                [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

                [processedImageFileNameArray addObject:newImageFileName];
            } else {
                [processedImageFileNameArray addObject:imageFileName];
            }

            matches = [expression matchesInString:fileContent options:0 range:NSMakeRange(0, fileContent.length)];
        }
    }
}

@end
