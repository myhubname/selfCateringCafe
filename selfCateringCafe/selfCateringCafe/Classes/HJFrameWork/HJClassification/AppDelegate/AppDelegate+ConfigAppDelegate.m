//
//  AppDelegate+ConfigAppDelegate.m
//  my_framework
//
//  Created by 胡俊杰 on 2019/2/25.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "AppDelegate+ConfigAppDelegate.h"
#import "HJCourseViewController.h"
@implementation AppDelegate (ConfigAppDelegate)

#pragma mark-设置导航栏
-(void)HJConfigNavigation
{
    // 设置是 全局使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是全局使用 （局部使用待开发）
    [WRNavigationBar wr_widely];
    // WRNavigationBar 不会对 blackList 中的控制器有影响 黑名单
    [WRNavigationBar wr_setBlacklist:@[
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor blackColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor blackColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];
    
}

#pragma mark-设置键盘
-(void)HJSetUpKeyBoard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
}


@end
