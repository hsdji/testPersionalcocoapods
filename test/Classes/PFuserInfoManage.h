//
//  userInfoManage.h
//  BaseProject
//
//  Created by DLM_iOS on 2018/8/2.
//  Copyright © 2018年 单小飞. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户信息保存 使用示例
                    保存 [UserInfoManager configInfo:@{@"key":@"value"}];
                    修改 [[UserInfoManager shareUser]setKeyName:value];
                    推出 [UserInfoManager loginOut]
                    读取 [[UserInfoManager shareUser] userID]
 */
@interface PFuserInfoManage : NSObject
//
//@property(nonatomic,copy)
//NSString *uesrname,
//*userSex,
//*userImgUrl,
//*userDesc,
//*token,
//*phone,
//*tokenPastTime,
//*wechatId,
//*wechatName,
//*sex,
//*normalToken,
//*regstID,
//*timestamp,
//*lat,
//*lon,
//*contans,
//*university_id,
//*university_name,
//*department_id,
//*department_name,
//*enroll_at,
//*enroll_at_show,
//*isFirstEnterSmalPage;


/**
 *
 通过单例模式对工具类进行初始化
 *
 */
+ (instancetype)shareUser;

/**
 *
 通过单例模式对工具类进行初始化
 *
 */
+ (void)configInfo:(NSDictionary *)infoDic;

/**
 *
 用户退出登录的操作
 *
 */
+ (void)loginOut;

@end
