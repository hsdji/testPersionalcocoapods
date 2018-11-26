//
//  resultViewController.h
//  碰面
//
//  Created by DLM_iOS on 2018/8/20.
//  Copyright © 2018年 dlm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMMusicSelectCell.h"

@interface resultViewController : UIViewController

/**
 音乐分类ID
 */
@property(nonatomic, assign) NSInteger ID;

/**
 点击使用音乐的回调 path:音乐地址 name:音乐名称 musicID:音乐ID
 */
@property(nonatomic, copy) void (^resultViewAudioBlock)
    (NSString *path, NSString *name, NSInteger musicID);

@end
