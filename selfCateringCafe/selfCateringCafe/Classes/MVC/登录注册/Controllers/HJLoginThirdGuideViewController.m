//
//  HJLoginThirdGuideViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJLoginThirdGuideViewController.h"
#import "HJLoginPhoneViewController.h"
@interface HJLoginThirdGuideViewController ()

@end

@implementation HJLoginThirdGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.customNavBar wr_setBackgroundAlpha:0];

    [self.customNavBar wr_setLeftButtonWithNormal:kGetImage(@"CloseIcon") highlighted:nil];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = kGetImage(@"LoginThirdBg");
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.view insertSubview:self.customNavBar aboveSubview:bgImageView];
    
//微信授权注册登录

    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setImage:kGetImage(@"weChatIcon") forState:UIControlStateNormal];
    wechatBtn.adjustsImageWhenHighlighted = NO;
    [bgImageView addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.offset(39);
        make.width.offset(238);
        make.bottom.offset(-180);
    }];
    
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setImage:kGetImage(@"phoneLoginBtn") forState:UIControlStateNormal];
    phoneBtn.adjustsImageWhenHighlighted = NO;
    [phoneBtn addTarget:self action:@selector(phonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(wechatBtn.mas_bottom).offset(30);
        make.width.equalTo(wechatBtn);
        make.height.equalTo(wechatBtn);
    }];
    

}

-(void)phonClick
{
    HJLoginPhoneViewController *loginVc = [[HJLoginPhoneViewController alloc] init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
}




@end
