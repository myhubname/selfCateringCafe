//
//  RecruitmentViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "RecruitmentViewController.h"
#import <WebKit/WebKit.h>
#import "HJPayTypeViewController.h"
@interface RecruitmentViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) UIProgressView *ProgressView;

@property (nonatomic, strong) WKWebView *wkWebView;

/** user */
@property (nonatomic,weak) WKUserContentController *userCc;

@end

@implementation RecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"联创招募";
    
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yhapp.ncid.cn/Index/openDean.html?uid=%@",userDefaultGet(userid)]]]];
    
    
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.ProgressView];
    
    
    
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.ProgressView.alpha = 1.0f;
        [self.ProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.ProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.ProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter and setter
- (UIProgressView *)ProgressView
{
    if (_ProgressView == nil) {
        _ProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, TopHeight, [UIScreen mainScreen].bounds.size.width, 0)];
        _ProgressView.tintColor = [UIColor colorWithHexString:@"#f65a5c"];
        _ProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _ProgressView;
}
- (WKWebView *)wkWebView
{
    if(_wkWebView == nil)
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-TabBarHeight) configuration:config];
        _wkWebView.opaque = NO;
        _wkWebView.multipleTouchEnabled = YES;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        self.userCc = config.userContentController;
        
        [self.userCc addScriptMessageHandler:self name:@"timefor"];
    }
    return _wkWebView;
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.body[@"code"] integerValue] == 0001) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        params[@"type"] = @(3);
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/toChange" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {             
                HJPayTypeViewController *payTypeVc = [[HJPayTypeViewController alloc] init];
                payTypeVc.snStr = result.data[@"sn"];
                [self.navigationController pushViewController:payTypeVc animated:YES];
                
            }
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
    }
    
}


- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [self.userCc removeScriptMessageHandlerForName:@"timefor"];
}




@end
