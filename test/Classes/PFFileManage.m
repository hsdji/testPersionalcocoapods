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
@end
