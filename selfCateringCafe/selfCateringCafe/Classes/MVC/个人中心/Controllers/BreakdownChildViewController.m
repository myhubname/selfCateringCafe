//
//  BreakdownChildViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "BreakdownChildViewController.h"
#import "BreakdownTableViewCell.h"
#import "HJGetPriceDetailTableViewCell.h"
@interface BreakdownChildViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/**数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation BreakdownChildViewController
static NSString *const identifer = @"identifer";

-(NSMutableArray *)modelArray
{
    if (!_modelArray) {
        
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.tableView];
    
    if ([self.type integerValue] == 1 || [self.type integerValue] == 2) {
        
        self.dataArray = @[@"直属会员",@"消费金额",@"直接奖励",@"时间"];
        
    }else
    {
        self.dataArray = @[@"收益种类",@"收益分红",@"时间"];
    }
    
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
    }else{
        
        [self.tableView.mj_header endRefreshing];
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userid"] = userDefaultGet(userid);
    parmas[@"index"] = @(self.currentPage);
    parmas[@"type"] = self.type;
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"/Api/User/profitDetail" params:parmas sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *dataArray = result.data;
            
            if (isHeader) {
                
                [self.tableView.mj_header endRefreshing];
                
                if (dataArray.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.modelArray removeAllObjects];
                [self.modelArray addObjectsFromArray:dataArray];
            
            }else
            {
                if (dataArray.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
                [self.modelArray addObjectsFromArray:dataArray];
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

#pragma mark-创建collectionview
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 60) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BreakDownCollectionViewCell class] forCellWithReuseIdentifier:identifer];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BreakDownCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.label.text = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type integerValue] == 1 || [self.type integerValue] == 2) {
        
        return  CGSizeMake(SCREEN_WIDTH/4, 60);

    }else
    {
        return CGSizeMake(SCREEN_WIDTH/3, 60);
    }
}

#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, self.collectionView.top+self.collectionView.height, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-self.collectionView.top-self.collectionView.height-50) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.modelArray.count == 0) {
        
        self.tableView.mj_footer.hidden = YES;
    }else
    {
        self.tableView.mj_footer.hidden = NO;
    }
    
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type integerValue] == 1 || [self.type integerValue] == 2) {
        
        static NSString *const identifer = @"identifer";
        
        BreakdownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[BreakdownTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        
        cell.oneLabel.text = self.modelArray[indexPath.row][@"user"];
        
        cell.twoLabel.text = self.modelArray[indexPath.row][@"consume"];
        
        cell.threeLabel.text = self.modelArray[indexPath.row][@"price"];
        
        cell.fourLabel.text = self.modelArray[indexPath.row][@"date"];
        
        return cell;
    }else
    {
        
        static NSString *const identifer = @"identifer";
        
        HJGetPriceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            
            cell = [[HJGetPriceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        
        cell.oneLabel.text = self.modelArray[indexPath.row][@"user"];
        cell.twoLabel.text = self.modelArray[indexPath.row][@"price"];
        cell.threeLabel.text = self.modelArray[indexPath.row][@"date"];

        return cell;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}




@end

@implementation BreakDownCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.label = alertLabel;
}



@end
