//
//  PersonalCenterViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalHeader.h"
#import "PersonalCenterMoreBtnTableViewCell.h"
#import "HJPersonalChnageBtnTableViewCell.h"
#import "SeverViewController.h"
#import "HJBaseWebViewController.h"
#import "inviteFriendsViewController.h"
#import "HJMineMessageViewController.h"
#import "PromotionOrderViewController.h"
#import "HJMyTeamViewController.h"
#import "HJPersonalSettingsViewController.h"
#import "HJMyIncomeViewController.h"
#import "MyCoursesViewController.h"
#import "HJCoffeeBeansViewController.h"
#import "HJUseTutorialViewController.h"
#import "HJDeanViewController.h"
@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 头部视图 */
@property (nonatomic,strong) PersonalHeader *headerView;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


@end

@implementation PersonalCenterViewController

-(void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar setTitle:@"个人中心"];
    
    [self.customNavBar wr_setRightButtonWithImage:kGetImage(@"SetIcon")];
    
    __weak typeof(self)weakself = self;
    self.customNavBar.onClickRightButton = ^{
        
        HJPersonalSettingsViewController *setVc = [[HJPersonalSettingsViewController alloc] init];
        
        [weakself.navigationController pushViewController:setVc animated:YES];
    };
    
    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];

    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [weakself getData];
        
    }];
    
    [weakself getData];
    

}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/CenterInfo" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dic = result.data;
            
            self.headerView.dic = self.dic;
            
            [self.tableView reloadData];
            
        }
        [self.tableView.mj_header endRefreshing];
    } Faild:^(NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark-头部视图
-(PersonalHeader *)headerView
{
    if (!_headerView) {
        
        _headerView = [[PersonalHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        __weak typeof(self)weakself = self;
        _headerView.block = ^{
            
            HJCoffeeBeansViewController *beansVc = [[HJCoffeeBeansViewController alloc] init];
            [weakself.navigationController pushViewController:beansVc animated:YES];
        };
        
        _headerView.goToYuanClick = ^{
          
            HJDeanViewController *deanVc = [[HJDeanViewController alloc] init];
            
            [weakself.navigationController pushViewController:deanVc animated:YES];
        };
        
    }
    return _headerView;
}
#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-TabBarHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *const identifer = @"PersonalCenterMoreBtnTableViewCell";
        
        PersonalCenterMoreBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[PersonalCenterMoreBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        __weak typeof(self)weakself = self;
        cell.moreBtnBlock = ^(NSInteger tag) {
          
            if (tag == 1) {
                
                PromotionOrderViewController *OrderVc = [[PromotionOrderViewController alloc] init];
                
                [weakself.navigationController pushViewController:OrderVc animated:YES];
            }else if (tag == 2)
            {
                HJMyTeamViewController *myteamVc = [[HJMyTeamViewController alloc] init];
                
                [weakself.navigationController pushViewController:myteamVc animated:YES];
            }else if (tag ==  3)
            {
                HJMyIncomeViewController *myinVc = [[HJMyIncomeViewController alloc] init];
                
                [weakself.navigationController pushViewController:myinVc animated:YES];
            }
            
        };
        
        
        return cell;
    }else
    {
        static NSString *const identifer = @"identifer";
        
        HJPersonalChnageBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[HJPersonalChnageBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.dataArray = @[
  @{@"image":@"CoffeeDoughnutIcon",@"name":@"咖粉圈"},
  @{@"image":@"InviteFrendIcon",@"name":@"邀请好友"},
  @{@"image":@"Mycourse",@"name":@"我的课程"},
  @{@"image":@"newsIcon",@"name":@"我的消息"},
  @{@"image":@"OrderSearch",@"name":@"平台动态"},
  @{@"image":@"newGuide",@"name":@"新手指引"},
  @{@"image":@"NoviceIcon",@"name":@"使用教程"},
  @{@"image":@"serverIcon",@"name":@"客服帮助"},
  ];
        
        __weak typeof(self)weakself = self;
        cell.didBlock = ^(NSString * _Nonnull name) {
          
            if ([name isEqualToString:@"咖粉圈"]) {
                
                weakself.tabBarController.selectedIndex = 1;
                
            }else if ([name isEqualToString:@"邀请好友"])
            {
                inviteFriendsViewController *vc = [[inviteFriendsViewController alloc] init];
                
                [weakself.navigationController pushViewController:vc animated:YES];
            }
            else if ([name isEqualToString:@"客服帮助"])
            {
                SeverViewController *severVc = [[SeverViewController alloc] init];
                [weakself.navigationController pushViewController:severVc animated:YES];
                
            }else if ([name isEqualToString:@"新手指引"])
            {
                [HUDManager showLoading];
             
                [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/News/getNewsList" params:@{@"index":@0,@"type":@3}.mutableCopy sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                    if (result.isSucess) {
                        
                        [HUDManager hidenHud];
                        
                        HJBaseWebViewController *webVC = [[HJBaseWebViewController alloc] init];
                        webVC.customNavBar.title = @"新手指引";
                        webVC.urlStr = [NSURL URLWithString:result.data[0][@"url"]];
                        [self.navigationController pushViewController:webVC animated:YES];
                        
                    }
                } Faild:^(NSError * _Nonnull error) {
                    
                }];
                                
            }else if ([name isEqualToString:@"我的消息"])
            {
                HJMineMessageViewController *MessageVc = [[HJMineMessageViewController alloc] init];
                MessageVc.customNavBar.title = @"我的消息";
                [self.navigationController pushViewController:MessageVc animated:YES];
 
            }else if ([name isEqualToString:@"我的课程"])
            {
                MyCoursesViewController *courseVc = [[MyCoursesViewController alloc] init];

                
                [self.navigationController pushViewController:courseVc animated:YES];
                
            }else if ([name isEqualToString:@"使用教程"])
            {
                HJUseTutorialViewController *useVc = [[HJUseTutorialViewController alloc] init];
                
                [self.navigationController pushViewController:useVc animated:YES];
                
            }
            
        };
        
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 120;
    }else
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 15;
    }else
    return 0.01;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 240-TopHeight*2)
    {
        CGFloat alpha = (offsetY - (240-TopHeight*2)) / TopHeight;
        
        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
    else
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
    }
    
}


@end
