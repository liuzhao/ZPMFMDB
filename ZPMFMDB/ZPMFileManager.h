//
//  ZPMFileManager.h
//  ZPMFMDB
//
//  Created by Liu Zhao on 2018/3/28.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPMFileManager : NSObject

+ (instancetype)sharedInstance;

/**
 获取Decument

 @return 路径
 */
- (NSString *)getDocumentPath;

/**
 获取Library
 
 @return 路径
 */
- (NSString *)getLibraryPath;

/**
 获取Cache
 
 @return 路径
 */
- (NSString *)getCachePath;

/**
 获取Tmp
 
 @return 路径
 */
- (NSString *)getTmpPath;

/**
 写入文件

 @param directoryPath 目标文件夹路径
 @param fileName 文件名
 @param text 内容
 */
- (void)createFileAtDirectory:(NSString *)directoryPath filePath:(NSString *)fileName text:(NSString *)text;

/**
 获取文件内容

 @param filePath 文件路径
 @return 内容
 */
- (NSString *)getTextAtFilePath:(NSString *)filePath;

@end
