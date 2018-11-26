//
//  PMmusicSelectViewController.h
//  碰面小视频
//
//  Created by spf on 2018/11/12.
//  Copyright © 2018年 dlm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMmusicSelectViewController : BaseViewController
@property(nonatomic, copy)void (^selectAudioBlock)(NSString *path, NSString *name,NSInteger musicID);
@end

NS_ASSUME_NONNULL_END
