//
//  HJSeverViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJSeverViewController.h"
#import "HJMoreClassTableViewCell.h"
#import "HJBaseWebViewController.h"
@interface HJSeverViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;


@end

@implementation HJSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"服务";
    
    [self.view addSubview:self.tableView];
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
        headerView.backgroundColor = [UIColor redColor];
        
        _tableView.tableHeaderView = headerView;
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";

    HJMoreClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJMoreClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataArray = @[@{@"image":@"mthjiaoyi",@"name":@"媒体号交易"},@{@"image":@"yygjxiazai",@"name":@"运营工具下载"},@{@"image":@"ycyuegao",@"name":@"原创约稿"},@{@"image":@"hfhuyue",@"name":@"互粉互阅"}];
    
    __weak typeof(self)weakself = self;
    cell.classBlock = ^(NSDictionary * _Nonnull dic) {
        
        HJBaseWebViewController *webVc = [[HJBaseWebViewController alloc] init];
        webVc.customNavBar.title = dic[@"name"];
        if ([dic[@"name"] isEqualToString:@"媒体号交易"]) {
            webVc.urlStr = [NSURL URLWithString:@"http://zmksxy.ncid.cn/Mobile/Index/agree/id/14.html"];
        }else if ([dic[@"name"] isEqualToString:@"运营工具下载"])
        {
            webVc.urlStr = [NSURL URLWithString:@"http://zmksxy.ncid.cn/Mobile/Index/agree/id/15.html"];
        }else if ([dic[@"name"] isEqualToString:@"原创约稿"])
        {
            webVc.urlStr = [NSURL URLWithString:@"http://zmksxy.ncid.cn/Mobile/Index/agree/id/16.html"];

        }else if ([dic[@"name"] isEqualToString:@"互粉互阅"])
        {
            webVc.urlStr = [NSURL URLWithString:@"http://zmksxy.ncid.cn/Mobile/Index/agree/id/17.html"];
        }
        [weakself.navigationController pushViewController:webVc animated:YES];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



@end
