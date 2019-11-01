//
//  HJBaseTableview.m
//  MusicHundred
//
//  Created by HJ_StyleMac on 2018/7/23.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import "HJBaseTableview.h"

@implementation HJBaseTableview

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andVc:(UIViewController *)vc
{
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0,*)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            //automaticallyAdjustsScrollViewIn，关闭自动偏移的系统优化
            vc.automaticallyAdjustsScrollViewInsets = NO;;
        }
        
    }
    return self;
}


@end
