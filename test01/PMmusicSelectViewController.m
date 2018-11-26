//
//  PMmusicSelectViewController.m
//  碰面小视频
//
//  Created by spf on 2018/11/12.
//  Copyright © 2018年 dlm. All rights reserved.
//

#import "PMmusicSelectViewController.h"
#import "resultViewController.h"
#import "PMAllScrollView.h"
#import "UIView+Size.h"
#import "PMmusicSearchVC.h"
@interface PMmusicSelectViewController ()<UISearchBarDelegate>

/** 容器 */
@property(nonatomic, strong) PMAllScrollView *scrollView;

/** 搜索*/
@property(nonatomic, strong) UISearchBar *searchBar;

@end

@implementation PMmusicSelectViewController

#pragma mark LifeStyle
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setUpUI];
  [self setEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"collectMusicRefresh"
                    object:nil];
}

#pragma mark PrivateMethod

/**
    设置偏移量回调事件
 */
- (void)setEvent {
  __weak typeof(self) weakSelf = self;
  self.scrollView.contentOffsetAction =
      ^(CGFloat contentOffsetX, CGFloat contentOffsetY, NSInteger tag) {
        weakSelf.scrollView.contentSize = CGSizeMake(0, 100 + 64);
      };
  //  所有tableView点击事件 tableViewTag：0 recommentTableView 1
  //  collectionTableVIew
  self.scrollView.block = ^(NSInteger tableViewTag, id pramars) {

  };
  //  选中使用音乐事件回调 path:音乐本地路径 name:音乐名称 musicID:音乐ID
  self.scrollView.PMAllScrollViewselectAudioBlock =
      ^(NSString *path, NSString *name, NSInteger musicID) {
        weakSelf.selectAudioBlock(path, name, musicID);
        [weakSelf.navigationController popViewControllerAnimated:YES];
      };
  //  音乐分类选中回调 musicCategoryID：音乐费分类对应ID  title：音乐分类名称
  self.scrollView.PMselectMusucCategory =
      ^(NSInteger musicCategoryID, NSString *title) {
        [[NSNotificationCenter defaultCenter]
            postNotificationName:@"PM_MUSICSELECT_STOP_PLAY"
                          object:nil];
        resultViewController *vc = [resultViewController new];
        vc.title = title;
        vc.ID = musicCategoryID;
        //          分类中点击使用音乐的回调 path:音乐映射的本地地址
        //          name:音乐名称
        vc.resultViewAudioBlock = ^(NSString *path, NSString *name,
                                    NSInteger musicID) {
          NSInteger count = weakSelf.navigationController.viewControllers.count;
          weakSelf.selectAudioBlock(path, name, musicID);
          UIViewController *controller =
              weakSelf.navigationController.viewControllers[count - 3];
          [weakSelf.navigationController popToViewController:controller
                                                    animated:YES];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
      };
}

#pragma mark CustomerApi

#pragma mark OtherApi
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
  __weak typeof(self) weakSelf = self;
  [[NSNotificationCenter defaultCenter]
      postNotificationName:@"PM_MUSICSELECT_STOP_PLAY"
                    object:nil];
  PMmusicSearchVC *vc = [PMmusicSearchVC new];
  vc.PMmusicSearchAudioBlock = ^(NSString *_Nonnull path,
                                 NSString *_Nonnull namem, NSInteger musicID) {
    weakSelf.selectAudioBlock(path, namem, musicID);
    NSInteger count = weakSelf.navigationController.viewControllers.count;
    UIViewController *controller =
        weakSelf.navigationController.viewControllers[count - 3];
    [weakSelf.navigationController popToViewController:controller animated:YES];
  };
  [self.navigationController pushViewController:vc animated:YES];

  return NO;
}

#pragma mark - getter / setter
- (PMAllScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[PMAllScrollView alloc]
        initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame),
                                 self.view.width, self.view.height)];
  }
  return _scrollView;
}

- (UISearchBar *)searchBar {
  if (!_searchBar) {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame =
        CGRectMake(20, kNavAndStatusHeight, kWindowW - 40, IPHONEHIGHT(44.0));
    _searchBar.placeholder = @"搜索歌曲名称";
    _searchBar.showsCancelButton = NO;
    _searchBar.backgroundImage =
        [UIImage imageWithColor:[UIColor whiteColor] cornerRadius:18];
    _searchBar.showsSearchResultsButton = NO;
    _searchBar.delegate = self;
    UIImageView *barImageView =
        [[[_searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    barImageView.layer.borderWidth = 1;
    UIView *searchTextField = nil;
    if (IOS_VERSION >= 7.0) {
      searchTextField =
          [[[_searchBar.subviews firstObject] subviews] lastObject];
    } else {
      for (UIView *subview in _searchBar.subviews) {
        if ([subview
                isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
          searchTextField = subview;
        }
      }
    }
    searchTextField.backgroundColor = kHexColor(0xF1F1F2);
    searchTextField.layer.cornerRadius = 5.0;
    [self.view addSubview:_searchBar];
  }
  return _searchBar;
}

- (void)dealloc {
  NSLog(@"销毁了");
}

#pragma mark setUpUI
- (void)setUpUI {
  self.title = @"音乐选择";
  [self.navigationController setNavigationBarHidden:NO animated:YES];
  [self.view addSubview:self.searchBar];
  [self.view addSubview:self.scrollView];
}
@end
