//
//  HJMyTeamViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJMyTeamViewController.h"
#import "HJMyTeamOneTableViewCell.h"
#import "HJTeamTypeHeader.h"
#import "HJTeamTableViewCell.h"
@interface HJMyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 头部视图 */
@property (nonatomic,strong) UIImageView *headerImageView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 类型 */
@property (nonatomic,assign) NSInteger type;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HJMyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"我的团队";
    
    [self.view addSubview:self.tableView];
    
    self.type = 1;
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.currentPage = 0;

        [weakself getMyTeamIsHeader:YES];

    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    
        weakself.currentPage += 1;
        
        [weakself getMyTeamIsHeader:NO];
        
    }];
    
    
}
#pragma mark-获取数据
-(void)getMyTeamIsHeader:(BOOL)isHeader
{
    if (isHeader) {
        
        [self.tableView.mj_header endRefreshing];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(@"userid");
    params[@"index"] = @(self.currentPage);
    params[@"type"] = @(self.type);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/myteam" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *dataArray = result.data[@"userList"];
            
            if (isHeader) {
                
                self.dic = result.data;
                
                [self.headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,result.data[@"banner"]]] placeholder:kGetImage(@"MyTeamHeader")];
                
                if (dataArray.count< 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.tableView.mj_header endRefreshing];
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:dataArray];
                
            }else
            {
                [self.dataArray addObjectsFromArray:dataArray];
                
                if (dataArray.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }
        }else
        {
            if (isHeader) {
                
                [self.tableView.mj_header endRefreshing];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
        
        [self.tableView reloadData];
    
    } Faild:^(NSError * _Nonnull error) {
        
        if (isHeader) {
            
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    
    
}
#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 183)];
        
        headerView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.image = kGetImage(@"MyTeamHeader");
        [headerView addSubview:headerImageView];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.offset(15);
            make.bottom.offset(-15);
        }];
        self.headerImageView = headerImageView;
        _tableView.tableHeaderView = headerView;
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 4;
    }else
    return [self.dic[@"userList"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
      
        static NSString *const identifer = @"identifer";
        
        HJMyTeamOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[HJMyTeamOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.line.hidden = YES;

        if (indexPath.row == 0) {
            
            cell.oneLabel.text = @"会员类型";
            cell.oneLabel.textColor = [UIColor blackColor];
            cell.twoLabel.text = @"总数";
            cell.twoLabel.textColor = [UIColor blackColor];
            cell.threeLabel.text = @"今日";
            cell.threeLabel.textColor = [UIColor blackColor];
            cell.fourLabel.text = @"本月";
            cell.fourLabel.textColor = [UIColor blackColor];
            cell.oneLabel.font = [UIFont systemFontOfSize:18];
            cell.twoLabel.font = [UIFont systemFontOfSize:18];
            cell.threeLabel.font = [UIFont systemFontOfSize:18];
            cell.fourLabel.font = [UIFont systemFontOfSize:18];
        
            cell.line.hidden = NO;
            
        }else
        {
            switch (indexPath.row) {
                case 1:
                {
                    cell.oneLabel.text = @"直邀VIP";
                    
                    cell.twoLabel.text = @"0";
                    
                    cell.threeLabel.text = @"0";
                    
                    cell.fourLabel.text = @"0";
                    
                }
                    break;
                    case 2:
                {
                    cell.oneLabel.text = @"直属会员";
                    cell.twoLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"all_count"]];
                    
                    cell.threeLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"today_all_count"]];
                    
                    cell.fourLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"month_all_count"]];
                }
                    break;
                    case 3:
                {
                    
                    cell.oneLabel.text = @"直属会员下级";
                    cell.twoLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"under_count"]];
                    
                    cell.threeLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"today_under_count"]];
                    
                    cell.fourLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"month_undert_count"]];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
        return cell;
        
        
    }else
    {
        static NSString *const identifer = @"identifer";
        
        HJTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[HJTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        
        cell.dic = self.dic[@"userList"][indexPath.row];
        
        return cell;
        
        
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            return 45;
        }else
        return 30;
    }else
     return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0.01;
    }else
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return nil;
    }else
    {
        HJTeamTypeHeader *headerView = [[HJTeamTypeHeader alloc] initWithReuseIdentifier:@"header"];
        
        headerView.type = self.type;
        __weak typeof(self)weakself = self;
        headerView.teamBlock = ^(NSInteger type) {
          
            weakself.type = type;
            
            [weakself.tableView.mj_header beginRefreshing];
        };
        return headerView;
    }

}


@end
