//
//  HJBaseViewController.h
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCustomNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface HJBaseViewController : UIViewController

/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势

@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

@end

NS_ASSUME_NONNULL_END
