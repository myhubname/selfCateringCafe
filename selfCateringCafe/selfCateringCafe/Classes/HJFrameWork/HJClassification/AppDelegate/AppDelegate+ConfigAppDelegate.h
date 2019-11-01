//
//  AppDelegate+ConfigAppDelegate.h
//  my_framework
//
//  Created by 胡俊杰 on 2019/2/25.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (ConfigAppDelegate)

/**
 设置导航栏
 */
-(void)HJConfigNavigation;

/**
 全局设置键盘管理者
 */
-(void)HJSetUpKeyBoard;

@end

NS_ASSUME_NONNULL_END
