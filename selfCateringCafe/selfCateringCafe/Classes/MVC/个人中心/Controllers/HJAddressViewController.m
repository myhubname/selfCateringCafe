//
//  HJAddressViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/14.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJAddressViewController.h"
#import "HJAddressFooter.h"
#import "HJAddressTableViewCell.h"
#import "HJAddAddressController.h"
@interface HJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 添加收获地址 */
@property (nonatomic,strong) UIButton *addAddressBtn;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 模型 */
@property (nonatomic,strong) NSMutableArray *dataModels;

@end

@implementation HJAddressViewController

-(NSMutableArray *)dataModels
{
    if (!_dataModels) {
        
        _dataModels = [NSMutableArray array];
    }
    return _dataModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.customNavBar.title = @"收货地址管理";
    
    [self.view addSubview:self.tableView];
    
    
    [self.view addSubview:self.addAddressBtn];
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        weakself.currentPage = 0;
        
        [weakself getData:YES];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
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
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/Address" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[HJAddressModel class] json:result.data];
            
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
                }else{
                    
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
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-TabBarHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.emptyDataSetSource = self;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataModels.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.model = self.dataModels[indexPath.section];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJAddressModel *model = self.dataModels[indexPath.section];

    CGFloat height = [[NSString stringWithFormat:@"收获地址:%@%@%@%@",model.pname,model.cname,model.rname,model.address] heightForFont:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH-30];
    
    return height + 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    HJAddressFooter *footer = [[HJAddressFooter alloc] initWithReuseIdentifier:@"footer"];
    
    footer.model = self.dataModels[section];
    
    __weak typeof(self)weakself = self;
    footer.setDefaultBlock = ^{
      
        [weakself.tableView.mj_header beginRefreshing];
        
    };
    
    
    footer.editBlock = ^(HJAddressModel * _Nonnull model) {
      
        HJAddAddressController *addVc = [[HJAddAddressController alloc] init];
        addVc.customNavBar.title = @"编辑收获地址";
        addVc.model = model;
        [weakself.navigationController pushViewController:addVc animated:YES];
        
    };
    
    
    return footer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.choseAddres) {
        
        self.choseAddres(self.dataModels[indexPath.section]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



-(UIButton *)addAddressBtn
{
    if (!_addAddressBtn) {
        
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAddressBtn setTitle:@"添加地址" forState:UIControlStateNormal];
        _addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addAddressBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF5243"]];
        _addAddressBtn.frame = CGRectMake(0, SCREENH_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight);
        [_addAddressBtn addTarget:self action:@selector(addAddressClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}

-(void)addAddressClick
{
    
    HJAddAddressController *addressVc = [[HJAddAddressController alloc] init];
    addressVc.customNavBar.title = @"添加收获地址";
    __weak typeof(self)weakself = self;
    addressVc.addAddressBlock = ^{
      
        [weakself.tableView.mj_header beginRefreshing];
        
    };
    
    [self.navigationController pushViewController:addressVc animated:YES];
    
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"暂无数据");
}
// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"暂无收获地址";

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
