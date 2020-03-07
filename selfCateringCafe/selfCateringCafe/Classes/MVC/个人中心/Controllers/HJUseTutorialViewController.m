//
//  HJUseTutorialViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJUseTutorialViewController.h"
#import "HJUseTutorialTableViewCell.h"
#import "HJBaseWebViewController.h"
@interface HJUseTutorialViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/**模型数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HJUseTutorialViewController

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
    params[@"index"] = @(self.currentPage);
    params[@"type"] = self.type;
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/News/getNewsList" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[UseTutorialModel class] json:result.data];
            
            if (isHeader) {
                
                if (models.count < 20) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:models];
                
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
            if (isHeader) {
                
                [self.tableView.mj_header endRefreshing];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    } Faild:^(NSError * _Nonnull error) {
        
        if (isHeader) {
            
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    
    
}

#pragma mark-创建UI
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count  == 0) {
        
        self.tableView.mj_footer.hidden = YES;
    }else
    {
        self.tableView.mj_footer.hidden = NO;
    }
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";

    HJUseTutorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJUseTutorialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UseTutorialModel *model = self.dataArray[indexPath.row];
    HJBaseWebViewController *webVc = [[HJBaseWebViewController alloc] init];
    webVc.customNavBar.title = model.topic;
    webVc.urlStr = [NSURL URLWithString:model.url];
    [self.navigationController pushViewController:webVc animated:YES];
    
    
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"暂无数据");
}
// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无数据";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
    
}
-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -TopHeight;
}

@end
