//
//  HJBaseViewController.m
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "HJBaseViewController.h"
@interface HJBaseViewController ()

@end

@implementation HJBaseViewController

- (id)init{
    self = [super init];
    if (self) {
        self.enablePanGesture = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;

    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"Nav_Bg"];

    self.customNavBar.titleLabelColor = [UIColor whiteColor];

    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithNormal:kGetImage(@"NavBack") highlighted:nil];
    }

}

- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

@end
