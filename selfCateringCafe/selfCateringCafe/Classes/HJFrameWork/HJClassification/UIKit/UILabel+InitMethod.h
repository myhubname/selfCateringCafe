//
//  UILabel+InitMethod.h
//  MusicHundred
//
//  Created by HJ_StyleMac on 2018/7/19.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (InitMethod)

/**
 快速构建Label

 @param font 字体大小
 @param textColor 字体颜色
 @return 返回Label
 */
+(instancetype)labelWithFontSize:(CGFloat)font textColor:(UIColor *)textColor;


@end
