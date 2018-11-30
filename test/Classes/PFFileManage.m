//
//  PFFileManage.m
//  PFFileManage
//
//  Created by spf on 2018/11/30.
//  Copyright © 2018年 spf. All rights reserved.
//

#import "PFFileManage.h"

@implementation PFFileManage
//获取document路径
+(NSString *)getDocumentPath{
    return  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

//判断路径是否存在
+(BOOL)isExitPath:(NSString *)path{
    if (path) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
        return NO;
    }
    return NO;
}

//创建文件夹
+(BOOL)createFloderWithPath:(NSString *)floderPath{
    if (floderPath) {
        if ([PFFileManage isExitPath:floderPath]) {
            return YES;
        }else{
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:floderPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                return NO;
            }
            return YES;
        }
    }
    return NO;
}
//图片写入到本地
+(BOOL)fileWriteToPath:(NSString *)path file:(NSData *)data{
    if (data) {
        NSError *error;
        [data writeToFile:path options:NSDataWritingAtomic error:&error];
        if (error) {
            NSLog(@"%@",error);
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

+(void)deleatePath:(NSString *)path{
    if (path) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}
@end
