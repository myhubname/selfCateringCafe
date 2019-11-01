//
//  HJLoginThirdGuideViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJLoginThirdGuideViewController.h"
#import "HJLoginPhoneViewController.h"
#import "HJBangdingViewController.h"
@interface HJLoginThirdGuideViewController ()<WXApiDelegate>

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
    [wechatBtn addTarget:self action:@selector(weChatClick) forControlEvents:UIControlEventTouchUpInside];
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
    
 
//    接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatSucess:) name:@"weChatSucess" object:nil];

}

-(void)weChatSucess:(NSNotification *)noti
{
    
    HJLog(@"%@",noti.object);
    [HUDManager showLoadingHud:@"正在获取用户信息..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"code"] = noti.object;
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Login/wxLogin" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            if ([result.data[@"isbind"] integerValue] == 0) {
                
                [HUDManager hidenHud];
                HJBangdingViewController *bangdingVc = [[HJBangdingViewController alloc] init];
                bangdingVc.dic = result.data;
                [self.navigationController pushViewController:bangdingVc animated:YES];
                
            }else
            {
                userDefaultSave(result.data[@"userid"], userid);
               
                [HUDManager showStateHud:@"登录成功" state:HUDStateTypeSuccess];
                
                [self dismissViewControllerAnimated:YES completion:nil];

            }
            
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
        
}



-(void)phonClick
{
    HJLoginPhoneViewController *loginVc = [[HJLoginPhoneViewController alloc] init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
}

-(void)weChatClick
{
    
    if ([WXApi isWXAppInstalled]&[WXApi isWXAppSupportApi]) {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        
        req.scope = @"snsapi_userinfo";
        
        req.state = @"wx_oauth_authorization_state";
        
        [WXApi sendReq:req completion:^(BOOL success) {
            
            if (success == NO) {
                
                [HUDManager showStateHud:@"微信注册失败" state:HUDStateTypeFail];
            }
        }];
        
    }else
    {
        [HUDManager showTextHud:@"未安装微信应用或版本过低"];
    }
    
    
    
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
