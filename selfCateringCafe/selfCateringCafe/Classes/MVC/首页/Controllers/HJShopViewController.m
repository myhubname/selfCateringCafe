//
//  HJShopViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJShopViewController.h"
#import "HJShopTopView.h"
#import "HJShopCollectionViewCell.h"
#import "ShopModel.h"
#import "HJShopDetailViewController.h"
@interface HJShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** topview */
@property (nonatomic,strong) HJShopTopView *topView;


/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 当前页 */
@property (nonatomic,assign) NSInteger currentPage;

/** 数组  */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HJShopViewController
static NSString *const identifer = @"identifer";

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"积分商城";
        
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.collectionView];
    
    __weak typeof(self)weakself = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.currentPage =  0;
        
        [weakself getDataIsHeader:YES];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
}
#pragma mark-获取商品
-(void)getDataIsHeader:(BOOL)isHeader
{
    if (isHeader) {
        
        [self.collectionView.mj_footer endRefreshing];
    }else
    {
        [self.collectionView.mj_header endRefreshing];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"index"] = @(self.currentPage);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Convert/getConvert" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            NSArray *models = [NSArray modelArrayWithClass:[ShopModel class] json:result.data[@"list"]];
            if (isHeader) {
                
                if (models.count < 20) {
                    
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                
                
                [self.collectionView.mj_header endRefreshing];
                
                [self.dataArray removeAllObjects];
                
                [self.dataArray addObjectsFromArray:models];

                
            }else{
                
                
                if (models.count < 20) {
                    
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.collectionView.mj_footer endRefreshing];
                }
                [self.dataArray addObjectsFromArray:models];
                
            }
            
            
        }else
        {
            if (isHeader) {
                
                [self.collectionView.mj_header endRefreshing];
                
            }else
            {
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        [self.collectionView reloadData];
    } Faild:^(NSError * _Nonnull error) {
        
        if (isHeader) {
            
            [self.collectionView.mj_header endRefreshing];
        }else
        {
            [self.collectionView.mj_footer endRefreshing];
        }
        
    }];
    
}

#pragma mark-顶部视图
-(HJShopTopView *)topView
{
    if (!_topView) {
        
        _topView = [[HJShopTopView alloc] initWithFrame:CGRectMake(0, TopHeight, 0, 0)];
    }
    return _topView;
}
#pragma mark-商品图片
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2+70);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topView.top+self.topView.height, SCREEN_WIDTH, SCREENH_HEIGHT-self.topView.top-self.topView.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [_collectionView registerClass:[HJShopCollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        
        self.collectionView.mj_footer.hidden = YES;
    }else
    {
        self.collectionView.mj_footer.hidden = NO;
    }
    
    return self.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJShopDetailViewController *detailVc = [[HJShopDetailViewController alloc] init];
    detailVc.detailId = [self.dataArray[indexPath.item] Id];
    [self.navigationController pushViewController:detailVc animated:YES];
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
