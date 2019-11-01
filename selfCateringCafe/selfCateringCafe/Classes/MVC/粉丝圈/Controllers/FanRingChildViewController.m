//
//  FanRingChildViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "FanRingChildViewController.h"
#import "FanRingTableViewCell.h"
#import "YBImageBrowser.h"
@interface FanRingChildViewController ()<UITableViewDelegate,UITableViewDataSource,FanRingTableViewCellDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger index;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FanRingChildViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.index = 0;
        
        [weakself getNewsList:YES];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        weakself.index += 1;
        
        [weakself getNewsList:NO];
        
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
}
#pragma mark-返回文章列表
-(void)getNewsList:(BOOL)IsHeader
{
    if (IsHeader) {
        
        [self.tableView.mj_footer endRefreshing];
    }else
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"index"] = @(self.index);
    params[@"type"] = self.Id;
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/News/getNewsList" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[FanRingModel class] json:result.data];
        
            if (IsHeader) {
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:models];

                if (models.count < 20) {
                
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.tableView.mj_header endRefreshing];
                
            }else
            {
                if (models.count < 20) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
            
                [self.dataArray addObjectsFromArray:models];

            }
            
            [self.tableView reloadData];
        }else
        {
            
            if (IsHeader) {
                
                [self.tableView.mj_header endRefreshing];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
        
        
    } Faild:^(NSError * _Nonnull error) {
        if (IsHeader) {
            
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
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-TabBarHeight-TopHeight-45) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    FanRingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[FanRingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FanRingModel *model = self.dataArray[indexPath.row];
    return model.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


-(void)cell:(FanRingTableViewCell *)cell didClickImageAtIndex:(NSUInteger)index
{
    NSMutableArray *datas = [NSMutableArray array];

    [cell.model.cover enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,obj]];
        data.projectiveView = cell.picViews[index];
        [datas addObject:data];

    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    [browser show];

}

-(void)cellDidClickRepost:(FanRingTableViewCell *)cell
{
    HJLog(@"转发");
}


@end
