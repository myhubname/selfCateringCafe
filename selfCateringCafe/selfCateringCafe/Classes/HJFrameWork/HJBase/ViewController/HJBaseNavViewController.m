//
//  HJBaseNavViewController.m
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "HJBaseNavViewController.h"

@interface HJBaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HJBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakself;
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

//可以在这个方法中拦截所有push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果push进来的不是第一个控制器
    if (self.childViewControllers.count>0)
    {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        //设置button的水平偏移,让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
        [button setImage:[UIImage imageNamed:@"NavReturnIcon"] forState:UIControlStateNormal];
//        [button setTitle:viewController.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed=YES;
    }
    //这句super的push要放在后面，让viewcontroller可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        if (self.viewControllers.count<2) {
            
            return NO;
        }
    }
    return YES;
}
@end
