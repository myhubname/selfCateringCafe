//
//  UIColor+HJHEX.h
//  Passersbyjun
//
//  Created by 嘉瑞科技有限公司 on 2017/9/9.
//  Copyright © 2017年 嘉瑞科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HJHEX)


/**
 十六进制创建UIColor

 @param hex 十六进制
 @return 返回颜色
 */
+(UIColor *)colorWithHex:(UInt32)hex;

/**
 十六进制创建UIColor
 @param hex 十六进制
 @param alpha 透明度
 @return 返回颜色
 */
+(UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 将颜色字符串转为颜色

 @param hexString 颜色字符串
 @return 返回颜色
 */
+(UIColor *)colorWithHexString:(NSString *)hexString;


/**
 将颜色转为字符串

 @return 返回颜色字符串
 */
-(NSString *)HEXString;



@end
