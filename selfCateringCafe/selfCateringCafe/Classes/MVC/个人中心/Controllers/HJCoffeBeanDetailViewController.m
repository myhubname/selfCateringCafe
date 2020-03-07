//
//  HJCoffeBeanDetailViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/12.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCoffeBeanDetailViewController.h"

@interface HJCoffeBeanDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 积分 */
@property (nonatomic,weak) UILabel *integralLabel;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation HJCoffeBeanDetailViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar setTitle:@"我的积分"];

    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    

    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.currentPage = 0;
        
        [weakself getDataIsHeader:YES];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        weakself.currentPage += 1;
        
        [weakself getDataIsHeader:NO];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark-获取数据
-(void)getDataIsHeader:(BOOL)isHeader
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
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/Integral" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
         
            NSArray *array = result.data[@"integralRecord"];
            
            if (isHeader) {
                
                self.integralLabel.text = [NSString stringWithFormat:@"%@分",result.data[@"integral"]];
                
                if (array.count< 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:array];
                
                [self.tableView.mj_header endRefreshing];
            
            }else
            {
                if (array.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                [self.dataArray addObjectsFromArray:array];
            }
            
        }else{
            
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
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F55C4E"];
        
        
        UILabel *priceLabel = [UILabel labelWithFontSize:20 textColor:[UIColor whiteColor]];
        
        priceLabel.font = [UIFont boldSystemFontOfSize:30];
        
        [headerView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(25);
        }];
        
        self.integralLabel = priceLabel;
        
        _tableView.tableHeaderView = headerView;
        
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"mark"];
   
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"date"];
    
    UILabel *accLabel =  [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
   
//    if ([self.dataArray[indexPath.row][@"type"] integerValue] == 2) {
//
//        accLabel.text = [NSString stringWithFormat:@"+%@",self.dataArray[indexPath.row][@"price"]];
//    }else
//    {
        accLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"price"]];
//    }
    
    accLabel.size = CGSizeMake(120, 30);
    
    accLabel.textAlignment = NSTextAlignmentRight;
    
    cell.accessoryView = accLabel;
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



@end
