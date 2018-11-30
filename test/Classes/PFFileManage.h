//
//  PFFileManage.h
//  PFFileManage
//
//  Created by spf on 2018/11/30.
//  Copyright © 2018年 spf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PFFileManage : NSObject

/**
 获取document目录
 */
+(NSString *)getDocumentPath;



/**
 根据路径创建文件夹 如果文件夹存在直接返回成功

 @param floderPath 文件夹路径
 @return 是否创建成功
 */
+(BOOL)createFloderWithPath:(NSString *)floderPath;


/**
 判断路径是否存在

 @param path 路径
 @return 是否存在
 */
+(BOOL)isExitPath:(NSString *)path;

/**
 图片写入本地

 @param path 保存路径
 @param image 图片
 @return 是否c写入成功
 */
+(BOOL)fileWriteToPath:(NSString *)path file:(NSData *)image;


/**
 删除文件或者路径

 @param path 要删除的路径
 */
+(void)deleatePath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
