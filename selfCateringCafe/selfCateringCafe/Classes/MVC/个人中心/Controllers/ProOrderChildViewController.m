//
//  ProOrderChildViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "ProOrderChildViewController.h"
#import "HJProOrderTableViewCell.h"
@interface ProOrderChildViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *modelsArray;

@end

@implementation ProOrderChildViewController

-(NSMutableArray *)modelsArray
{
    if (!_modelsArray) {
        
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"推广订单";

    [self.view addSubview:self.tableView];
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        weakself.currentPage = 0;
        [weakself loadData:YES];
        
    }];
    
    [weakself.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.currentPage += 1;
        
        [weakself loadData:NO];
    }];
    
}

#pragma mark-获取数据
-(void)loadData:(BOOL)isHeader
{
    if (isHeader) {
        
        [self.tableView.mj_header endRefreshing];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"index"] = @(self.currentPage);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/recOrder" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[HJProOrderModel class] json:result.data];
            
            if (isHeader) {
                
                if (models.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
                
                [self.tableView.mj_header endRefreshing];
                
                [self.modelsArray removeAllObjects];
                
                [self.modelsArray addObjectsFromArray:models];
                
                
            }else
            {
                
                if (models.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];

                }else{
                    
                    [self.tableView.mj_footer endRefreshing];

                }
                
                
                [self.modelsArray addObjectsFromArray:models];
                
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

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.modelsArray.count == 0) {
        
        self.tableView.mj_footer.hidden = YES;
    }else
    {
        self.tableView.mj_footer.hidden = NO;
    }
    return self.modelsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJProOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJProOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.model = self.modelsArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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

