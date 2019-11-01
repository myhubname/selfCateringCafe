//
//  WRHelper.m
//  CoolMarket
//
//  Created by ruixingchen on 4/16/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

#import "WRHelper.h"

@implementation WRHelper

///判断是否是圆角屏幕
+ (BOOL)isRoundCornerScreen {
    BOOL round = NO;

    // 判断安全区域, 只支持 iOS11 以上
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets inset = [WRHelper mainWindowSafeAreaInsets];
        round = round || inset.top > 0;
        round = round || inset.right > 0;
        round = round || inset.bottom > 0;
        round = round || inset.left > 0;
    }

    return round;
}

+ (UIEdgeInsets) mainWindowSafeAreaInsets {
    return [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
}

///设备的状态栏高度, 不管状态栏是否显示
+ (CGFloat)defaultStatusBarHeight {
    if (![WRHelper isRoundCornerScreen]) {
        //非全面屏, 默认就是20
        return 20;
    }else {
        UIEdgeInsets inset = [WRHelper mainWindowSafeAreaInsets];
        UIInterfaceOrientation statusBarOrientation = UIApplication.sharedApplication.statusBarOrientation;
        switch (statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
                return inset.top;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                return inset.bottom;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                return inset.left;
                break;
            case UIInterfaceOrientationLandscapeRight:
                return inset.right;
                break;
            default:
                return inset.top;
                break;
        }
    }

}

///设备当前的状态栏高度, 隐藏的话则为 0
+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)defaultNavBarHeight {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (@available(iOS 12.0, *)) {
            return 50;
        }
    }
    return 44;
}

+ (CGFloat)defaultNavBarBottom {
    CGFloat height = [WRHelper defaultStatusBarHeight] + [WRHelper defaultNavBarHeight];
    return height;
}

+ (CGFloat)defaultTabBarHeight {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (@available(iOS 12.0, *)) {
            return 50;
        }
    }
    return 49;
}

+ (CGFloat) defaultTabBarTop {
    return [WRHelper mainWindowSafeAreaInsets].bottom + [WRHelper defaultTabBarHeight];
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end


