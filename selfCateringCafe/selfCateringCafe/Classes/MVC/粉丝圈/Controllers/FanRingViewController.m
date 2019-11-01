//
//  FanRingViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "FanRingViewController.h"
#import "FanRingChildViewController.h"
@interface FanRingViewController ()

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;


@end

@implementation FanRingViewController

-(instancetype)init
{
    if (self = [super init]) {
        
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = [UIColor colorWithHexString:@"#fd5b48"];
        self.titleColorNormal = [UIColor blackColor];
        self.titleColorSelected = [UIColor colorWithHexString:@"fd5b48"];
        self.automaticallyCalculatesItemWidths = YES;
        self.progressViewIsNaughty = YES;
    }
    return self;
}
#pragma mark-获取新闻分类
-(void)getNewsCate
{
    [HUDManager showLoading];
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/News/getNewsCate" params:@{}.mutableCopy sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            NSMutableArray *titlesArray = [NSMutableArray array];
            
            [result.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                if ([obj[@"topic"] isEqualToString:@"新手指引"]) {
                    
                    
                }else
                {
                    [titlesArray addObject:obj[@"topic"]];

                }
            }];
            
            self.titles = titlesArray;
            
            self.dataArray = result.data;
        }
        [self reloadData];
        
    } Faild:^(NSError * _Nonnull error) {
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"素材库";
    
    [self wr_setNavBarShadowImageHidden:YES];
    
    [self wr_setNavBarBarTintColor:[UIColor colorWithHexString:@"#fd5947"]];

    
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    
    [self getNewsCate];
    
}


-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    FanRingChildViewController *vc = [[FanRingChildViewController alloc] init];
    
    vc.Id = self.dataArray[index][@"Id"];
    
    return vc;
}

-(CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView
{
    return CGRectMake(0, TopHeight, SCREEN_WIDTH, 45);
}

-(CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView
{
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    
    return CGRectMake(0, originY, SCREEN_WIDTH, self.view.height-originY);
}

@end
