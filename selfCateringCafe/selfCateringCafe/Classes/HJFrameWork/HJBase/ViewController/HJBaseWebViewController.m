//
//  HJBaseWebViewController.m
//  MusicHundred
//
//  Created by HJ_StyleMac on 2018/7/25.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import "HJBaseWebViewController.h"
#import <WebKit/WebKit.h>
@interface HJBaseWebViewController ()

@property (nonatomic, strong) UIProgressView *ProgressView;

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation HJBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.ProgressView];
    
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.ProgressView];

    if ([self.urlStr isKindOfClass:[NSURL class]]) {
        
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:self.urlStr]];
    
    }else
    {
        
        [self.wkWebView loadHTMLString:[self htmlEntityDecode:self.urlStr] baseURL:nil];
        
    }
    

}

- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight)];
        _wkWebView.opaque = NO;
        _wkWebView.multipleTouchEnabled = YES;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _wkWebView;
}
- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
