//
//  CourseChildViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "CourseChildViewController.h"
#import "MyCourseTableViewCell.h"
#import "HJCourseDetailViewController.h"
@interface CourseChildViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;



@end

@implementation CourseChildViewController

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
       
        [weakself getHeader:YES];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        weakself.currentPage += 1;
        
        [weakself getHeader:NO];
        
    }];
    
}
#pragma mark-获取数据
-(void)getHeader:(BOOL)isHeader
{
    if (isHeader) {
        
        [self.tableView.mj_footer endRefreshing];
    }else
    {
        [self.tableView.mj_header endRefreshing];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"type"] = @(self.type);
    params[@"index"] = @(self.currentPage);
    
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/myCourse" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *datalist = result.data;
            
            if (isHeader) {
                
                if (datalist.count < 5) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:datalist];
                
                [self.tableView.mj_header endRefreshing];
                
            }else
            {
                if (datalist.count < 5) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
        
                [self.dataArray addObjectsFromArray:datalist];

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
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-50) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
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
    
    MyCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[MyCourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.dic = self.dataArray[indexPath.row];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJCourseDetailViewController *courseVc = [[HJCourseDetailViewController alloc] init];
    courseVc.courseDetail_Id = self.dataArray[indexPath.row][@"cid"];
    [self.navigationController pushViewController:courseVc animated:YES];
    
}


@end
