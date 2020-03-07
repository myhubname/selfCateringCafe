//
//  UIViewController+HJAlertController.m
//  WorkToSee
//
//  Created by HJ_StyleMac on 2018/9/8.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import "UIViewController+HJAlertController.h"

@implementation UIViewController (HJAlertController)

-(void)alertVcTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle leftTitleColor:(UIColor *)leftColor leftClick:(void (^)(id))leftClick rightTitle:(NSString *)rightTitle righttextColor:(UIColor *)rightTextColor andRightClick:(void (^)(id))rightClick{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftaction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftClick(action);
    }];
    
    [leftaction setValue:leftColor forKey:@"titleTextColor"];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        rightClick(action);
        
    }];
    [rightAction setValue:rightTextColor forKey:@"titleTextColor"];
    
    
    [alertVc addAction:leftaction];
    [alertVc addAction:rightAction];
    
    
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];
}

-(void)sheetAlertVcNoTitleAndMessage:(UIColor *)bottomColor bottomBlock:(void(^)(id))bottomBlock BottomTitle:(NSString *)bottomTitle TopTitle:(NSString *)TopTitle TopTitleColor:(UIColor *)topTitleColor topBlock:(void(^)(id))topBlock secondTitle:(NSString *)secondTitle secondColor:(UIColor *)secondColor secondBlock:(void(^)(id))secondBlock{
    
    UIAlertController *sheetAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:bottomTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        bottomBlock(action);
    }];
    [CancelAction setValue:bottomColor forKey:@"titleTextColor"];
    [sheetAlert addAction:CancelAction];
    
    UIAlertAction *topAction = [UIAlertAction actionWithTitle:TopTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        topBlock(action);
    }];
    [topAction setValue:topTitleColor forKey:@"titleTextColor"];
    [sheetAlert addAction:topAction];
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        secondBlock(action);
    }];
    [secondAction setValue:secondColor forKey:@"titleTextColor"];
    [sheetAlert addAction:secondAction];

    [self presentViewController:sheetAlert animated:YES completion:^{
        
    }];
}

-(void)showAlertTexfMessage:(NSString *)message placeHodel:(NSString *)placeHodel leftTitle:(NSString *)leftTitle leftClick:(void (^)(id))leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void (^)(id))rightBlock
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHodel;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        leftBlock(action);
    }];
    [alertVc addAction:cancelAction];
    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    UIAlertAction *determinAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *textField = alertVc.textFields.firstObject;
        
        rightBlock(textField);
        
    }];
    
    [determinAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertVc addAction:determinAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
}


@end
