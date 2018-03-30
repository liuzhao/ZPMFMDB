//
//  ZPMFileManager.m
//  ZPMFMDB
//
//  Created by Liu Zhao on 2018/3/28.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ZPMFileManager.h"

@interface ZPMFileManager()

@end

@implementation ZPMFileManager

+ (instancetype)sharedInstance
{
    static ZPMFileManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZPMFileManager alloc] init];
    });
    return instance;
}

- (NSString *)getDocumentPath
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    return path;
}

- (NSString *)getLibraryPath
{
    NSString *path = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
    return path;
}

- (NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

- (NSString *)getTmpPath
{
    NSString *path = NSTemporaryDirectory();
    return path;
}

- (void)createFileAtDirectory:(NSString *)directoryPath filePath:(NSString *)fileName text:(NSString *)text
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:directoryPath]) {
        // 创建ZPMHome文件夹
        NSError *error;
        [fileManager createDirectoryAtPath:directoryPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
    }
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:fileName
                         contents:data
                       attributes:nil];
}

- (NSString *)getTextAtFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 获取HomeList数据
    NSData *data = [fileManager contentsAtPath:filePath];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSArray *)getFileSubpaths:(NSString *)path
{
    return [[NSFileManager defaultManager] subpathsAtPath:path];
}

- (BOOL)createFileAtPath:(NSString *)path contents:(nullable NSData *)data attributes:(nullable NSDictionary<NSFileAttributeKey, id> *)attr
{
    return [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:attr];
}

- (void)zpm_userDefaults_setObject:(nullable id)value forKey:(NSString *)defaultName isSynchronize:(BOOL)isSynchronize
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    if (isSynchronize) {
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
