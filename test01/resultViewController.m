//
//  resultViewController.m
//  碰面
//
//  Created by DLM_iOS on 2018/8/20.
//  Copyright © 2018年 dlm. All rights reserved.
//

#import "resultViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BaseNetManager.h"
#import "musicViewModel.h"
@interface resultViewController ()<UITableViewDelegate, UITableViewDataSource> {
  NSString *currentUrl;  //当前的音乐网络地址
  UIButton *btn;         //返回
}
@property(nonatomic, strong) UITableView *tableView;
;

@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, strong) NSIndexPath *currentIndexPath;

@property(nonatomic, copy) NSString *currentPath;

@property(nonatomic, copy) NSString *MusicName;

@property(nonatomic, copy) NSString *musicID;

@property(nonatomic, strong) musicViewModel *listModel;
@end

@implementation resultViewController

- (void)viewDidLoad {
  [self.navigationController setNavigationBarHidden:NO animated:YES];
  [super viewDidLoad];
  [self addBack];
  [self setUpUI];
  [self configData];
}

#pragma - mark ConfigData

/**
 添加返回逻辑
 */
- (void)addBack {
  btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
  btn.frame = CGRectMake(
      0, 0, 60, self.navigationController.navigationBar.frame.size.height);
  [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
  [btn bk_addEventHandler:^(id sender) {
    kAppDelegate.muscName = @"";
    kAppDelegate.musicPath = @"";
    [self.navigationController popViewControllerAnimated:YES];
  }
         forControlEvents:UIControlEventTouchUpInside];
}

/**
 设置
 */
- (void)setNavi {
  UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
  self.navigationItem.leftBarButtonItems =
      [NSArray arrayWithObjects:menuItem, nil];
}

/**
 请求数据 刷新列表 填充
 */
- (void)configData {
  _listModel = [musicViewModel new];
  [_listModel getDataWithPragram:@{
    @"cate_id" : @(self.ID),
    @"l" : @(30)
  }
      FromNetCompleteHandle:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self hideProgress];
        if (error) {
        } else {
          if ([_listModel haveMore]) {
            [self.tableView.mj_footer resetNoMoreData];
          } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
          }
          [_tableView reloadData];
        }
      }];
}

/**
 设置tableVIew的fotter加载更多数据
 */
- (void)setTableViewFotter {
  self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    if ([_listModel haveMore]) {
      [self showProgress];
      [_listModel getMoreDataWithPragram:@{
        @"cate_id" : @(self.ID),
        @"l" : @(30)
      }
          CompletionHandle:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            [self hideProgress];
            if (error) {
            } else {
              if ([_listModel haveMore]) {
                [self.tableView.mj_footer resetNoMoreData];
              } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
              }
              [_tableView reloadData];
            }
          }];
    } else {
      [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
  }];
}

#pragma UITableViewDelegate &&UITableViewdaaouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [_listModel getRowNumber];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([indexPath isEqual:_currentIndexPath]) {
    return 150;
  }
  return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PMMusicSelectCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"PMMusicSelectCell"];
  cell.tag = indexPath.row;
  __weak typeof(self) weakSelf = self;
  MusicListData *data = [_listModel getMuscModel:indexPath];
  cell.tag = indexPath.row;
  [cell setModel:data
           event:^(NSInteger tag, NSInteger index) {
             if (tag == 1) {
               [weakSelf useMusicAction:[NSIndexPath indexPathForRow:index
                                                           inSection:0]];
             } else {
               [weakSelf
                   collectMusicWithIndexPath:[NSIndexPath indexPathForRow:index
                                                                inSection:0]];
             }
           }];
  if ([indexPath isEqual:_currentIndexPath]) {
    cell.musicUseBtn.hidden = NO;
    [cell changePlayState:0];
  } else {
    cell.musicUseBtn.hidden = YES;
    [cell changePlayState:1];
  }
  return cell;
}

/**
 点击收藏按钮的回调

 @param indexPath 点击的索引值
 */
- (void)collectMusicWithIndexPath:(NSIndexPath *)indexPath {
  __weak typeof(self) weakSelf = self;
  __block MusicListData *data = [_listModel getMuscModel:indexPath];
  [BaseNetManager POST:[kMusic stringByAppendingString:@"/sec/music"]
      parameters:@{
        @"music_id" : @(data.ID)
      }
      completionHandler:^(id responseObj, NSError *error) {
        if (error) {
          [SVProgressHUD showErrorWithStatus:@"失败"];
        } else {
          data.is_favorite = !data.is_favorite;
          [_listModel.dataArr replaceObjectAtIndex:indexPath.row
                                        withObject:data];
          if (data.is_favorite) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
          } else {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
          }
        }
        [weakSelf.tableView reloadData];
      }];
}

/**
 点击使用音乐的回调，下载音乐 回传音乐本地路径，音乐名称，音乐ID

 @param indexPath 点击的索引值
 */
- (void)useMusicAction:(NSIndexPath *)indexPath {
  __weak typeof(self) weakSelf = self;
  [_player pause];
  NSString *url;
  NSString *name;
  NSString *DI;
  MusicListData *data = [_listModel getMuscModel:indexPath];
  url = data.url;
  name = data.name;
  DI = [NSString stringWithFormat:@"%ld", data.ID];
  NSString *fullPath = [[[NSSearchPathForDirectoriesInDomains(
      NSCachesDirectory, NSUserDomainMask, YES) lastObject]
      stringByAppendingPathComponent:[NSString md5:url]]
      stringByAppendingString:@".mp3"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
    [SVProgressHUD show];
    [BaseNetManager downLoadMusic:url
                completionHandler:^(NSURL *responseObj, NSError *error) {
                  [SVProgressHUD dismiss];
                  [weakSelf hideProgress];
                  if (error) {
                    [weakSelf showErrorMsg:@"音乐获取失败,"
                                           @"请稍后再试失败"];
                  } else {
                    kAppDelegate.musicPath = fullPath;
                    kAppDelegate.muscName = name;
                    kAppDelegate.muscid = DI;
                    if (weakSelf.resultViewAudioBlock) {
                      weakSelf.resultViewAudioBlock(fullPath, name, data.ID);
                    }
                  }
                }];
  } else {
    kAppDelegate.musicPath = fullPath;
    kAppDelegate.muscName = name;
    kAppDelegate.muscid = DI;
    if (weakSelf.resultViewAudioBlock) {
      weakSelf.resultViewAudioBlock(fullPath, name, data.ID);
    }
  }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([_currentIndexPath isEqual:indexPath]) {
    [self.player pause];
    self.player = nil;
    _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:100];
    [tableView reloadData];
  } else {
    PMMusicSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.musicUseBtn.hidden = NO;
    _currentIndexPath = indexPath;
    MusicListData *data = [_listModel getMuscModel:indexPath];
    [self playWithUrl:data.url];
    [tableView reloadData];
  }
}

/**
 循环播放音乐 点击播放之前把之前的播放暂停

 @param url 要播放的音乐地址
 */
- (void)playWithUrl:(NSString *)url {
  [self.player pause];
  __block AVPlayerItem *item =
      [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
  self.player = [AVPlayer playerWithPlayerItem:item];
  [self.player play];
  __weak typeof(self) weakSelf = self;
  [self.player
      addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC)
                                   queue:NULL
                              usingBlock:^(CMTime time) {
                                CGFloat progress =
                                    CMTimeGetSeconds(weakSelf.player.currentItem
                                                         .currentTime) /
                                    CMTimeGetSeconds(
                                        weakSelf.player.currentItem.duration);
                                if (progress == 1.0f) {
                                  item = nil;
                                  weakSelf.player = nil;
                                  [weakSelf playWithUrl:url];
                                }
                              }];
}

#pragma - mark - PrivateMethod

- (void)setUpUI {
  [self setNavi];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.tableView];
}

#pragma - mark LazyLoad
- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    [_tableView registerClass:[PMMusicSelectCell class]
        forCellReuseIdentifier:@"PMMusicSelectCell"];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.view).offset(kNavAndStatusHeight);
      make.left.right.bottom.mas_equalTo(0);
    }];
    [self setTableViewFotter];
  }
  return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.player pause];
}

@end

