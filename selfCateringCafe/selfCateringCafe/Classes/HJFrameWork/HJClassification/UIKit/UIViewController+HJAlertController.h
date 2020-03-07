//
//  UIViewController+HJAlertController.h
//  WorkToSee
//
//  Created by HJ_StyleMac on 2018/9/8.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HJAlertController)


/**
 弹出提示框

 @param title 标题
 @param message 提示消息
 @param leftTitle 左侧按钮标题
 @param leftColor 左侧按钮颜色
 @param leftClick 左侧按钮点击事件回调
 @param rightTitle 右侧按钮标题
 @param rightTextColor 右侧按钮颜色
 @param rightClick 右侧按钮点击事件
 */
-(void)alertVcTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle leftTitleColor:(UIColor*)leftColor leftClick:(void(^)(id leftClick))leftClick rightTitle:(NSString *)rightTitle righttextColor:(UIColor *)rightTextColor andRightClick:(void(^)(id rightClick))rightClick;


/**
 地部弹出视图

 @param bottomColor 底步按钮颜色
 @param bottomBlock 底步点击事件
 @param bottomTitle 底部按钮文字
 @param TopTitle 顶部按钮标题
 @param topTitleColor 顶部按钮文字颜色
 @param topBlock 顶部按钮点击回调
 @param secondTitle 第二个按钮标题
 @param secondColor 第二个按钮标题颜色
 @param secondBlock 第二个按钮回调
 */
-(void)sheetAlertVcNoTitleAndMessage:(UIColor *)bottomColor bottomBlock:(void(^)(id))bottomBlock BottomTitle:(NSString *)bottomTitle TopTitle:(NSString *)TopTitle TopTitleColor:(UIColor *)topTitleColor topBlock:(void(^)(id))topBlock secondTitle:(NSString *)secondTitle secondColor:(UIColor *)secondColor secondBlock:(void(^)(id))secondBlock;


-(void)showAlertTexfMessage:(NSString *)message placeHodel:(NSString *)placeHodel leftTitle:(NSString *)leftTitle leftClick:(void (^)(id))leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void (^)(id))rightBlock;


@end
