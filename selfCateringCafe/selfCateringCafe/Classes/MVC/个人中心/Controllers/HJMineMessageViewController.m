//
//  HJMineMessageViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJMineMessageViewController.h"
#import "HJMessageModel.h"
#import "MyMessageTableViewCell.h"
@interface HJMineMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 模型数据 */
@property (nonatomic,strong) NSMutableArray *dataModels;



@end

@implementation HJMineMessageViewController

-(NSMutableArray *)dataModels
{
    if (!_dataModels) {
        
        _dataModels = [NSMutableArray array];
    }
    
    return _dataModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.currentPage = 0;
        [weakself getData:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        weakself.currentPage += 1;
        
        [weakself getData:NO];
        
    }];
    
}
#pragma mark-获取数据
-(void)getData:(BOOL)isHeader
{
    
    if (isHeader) {
        
        [self.tableView.mj_footer endRefreshing];
    }else
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"index"] = @(self.currentPage);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/getMessage" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[HJMessageModel class] json:result.data[@"msg"]];
            
            if (isHeader) {
                
                
                if (models.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                }

                [self.dataModels removeAllObjects];
                
                
                [self.dataModels addObjectsFromArray:models];
                
                [self.tableView.mj_header endRefreshing];
                
            }else
            {
                if (models.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
                [self.dataModels addObjectsFromArray:models];
                
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


-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    MyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[MyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    HJMessageModel *model = self.dataModels[indexPath.row];
  
    cell.model = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
