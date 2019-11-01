//
//  UILabel+InitMethod.m
//  MusicHundred
//
//  Created by HJ_StyleMac on 2018/7/19.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import "UILabel+InitMethod.h"

@implementation UILabel (InitMethod)

+(instancetype)labelWithFontSize:(CGFloat)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    return label;
}

@end
