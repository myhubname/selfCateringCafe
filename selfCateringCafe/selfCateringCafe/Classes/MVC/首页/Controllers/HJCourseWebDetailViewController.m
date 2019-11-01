//
//  HJCourseWebDetailViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/10.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseWebDetailViewController.h"
#import <WebKit/WebKit.h>

@interface HJCourseWebDetailViewController ()

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation HJCourseWebDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.wkWebView];
    
}
- (WKWebView *)wkWebView
{
    if(_wkWebView == nil)
    {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-250-50)];
        _wkWebView.opaque = NO;
        _wkWebView.multipleTouchEnabled = YES;
    }
    
    return _wkWebView;
}


-(void)setWebUrl:(NSString *)webUrl
{
    _webUrl = webUrl;
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
}

@end
