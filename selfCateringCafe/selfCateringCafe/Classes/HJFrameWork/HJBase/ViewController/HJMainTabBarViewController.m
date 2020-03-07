//
//  HJMainTabBarViewController.m
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "HJMainTabBarViewController.h"
#import "HJBaseNavViewController.h"
#import "HJLoginThirdGuideViewController.h"
@interface HJMainTabBarViewController ()<UITabBarControllerDelegate>

@property(nonatomic,assign) NSInteger Index;

@end

@implementation HJMainTabBarViewController

#pragma mark-初始化配置tabbar
+(void)initialize
{
    NSMutableDictionary *attrd=[NSMutableDictionary dictionary];
    attrd[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attrd[NSForegroundColorAttributeName]=[UIColor colorWithHexString:@"#565656"];
    
    NSMutableDictionary *selectedattrd=[NSMutableDictionary dictionary];
    selectedattrd[NSFontAttributeName]=attrd[NSFontAttributeName];
    selectedattrd[NSForegroundColorAttributeName]= [UIColor colorWithHexString:@"#fd3029"];
    
    [[UITabBar appearance] setTranslucent:NO];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    UITabBarItem *itm=[UITabBarItem appearance];
    [itm setTitleTextAttributes:attrd forState:UIControlStateNormal];
    [itm setTitleTextAttributes:selectedattrd forState:UIControlStateSelected];
    
}
#pragma mark-初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.delegate = self;
    
    [
@[@{@"Class":@"HomPageViewController",@"name":@"首页",@"image":@"homeTabbarIconNomer",@"sel_image":@"homeTabbarIconSel"},
  @{@"Class":@"FanRingViewController",@"name":@"素材库",@"image":@"CoffeeTabbarNomer",@"sel_image":@"CoffeeTabbarSel"},
 
  @{@"Class":@"RecruitmentViewController",@"name":@"联创招募",@"image":@"CooperationTabbarNomer",@"sel_image":@"CooperationTabbarSel"},
  @{@"Class":@"HJWelfareViewController",@"name":@"福利社",@"image":@"WelfareTabbarNomer",@"sel_image":@"WelfareTabbarSel"},
  @{@"Class":@"PersonalCenterViewController",@"name":@"个人中心",@"image":@"personalTabbarNomer",@"sel_image":@"personalTabbarSel"},
  
      
       ] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
           [self setupChild:[[NSClassFromString(obj[@"Class"]) alloc] init] title:obj[@"name"] image:obj[@"image"] selectedImage:obj[@"sel_image"]];
       }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabbar:) name:@"changeTabbar" object:nil];

}

#pragma mark-初始化控制器
-(void)setupChild:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.image= [UIImage imageNamed:image];

    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    vc.tabBarItem.selectedImage=[vc.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HJBaseNavViewController *NavVc = [[HJBaseNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:NavVc];
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"个人中心"]) {
        
        if (userDefaultGet(userid) == nil) {

            HJLoginThirdGuideViewController *thirdLogin = [[HJLoginThirdGuideViewController alloc] init];
            
            HJBaseNavViewController *nav = [[HJBaseNavViewController alloc] initWithRootViewController:thirdLogin];
            
            [viewController presentViewController:nav animated:YES completion:nil];
            
            return NO;
        }else{
            
            HJLog(@"登录了");
        }
    }
    return YES;
}

-(void)changeTabbar:(NSNotification *)noti
{
    self.Index = [[noti object] integerValue];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
}
-(void)delayMethod
{
    self.selectedIndex = self.Index;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
