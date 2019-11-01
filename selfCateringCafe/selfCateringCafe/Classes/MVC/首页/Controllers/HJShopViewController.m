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
@interface HJShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** topview */
@property (nonatomic,strong) HJShopTopView *topView;


/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HJShopViewController
static NSString *const identifer = @"identifer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"商城";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.collectionView];
    
}
#pragma mark-顶部视图
-(HJShopTopView *)topView
{
    if (!_topView) {
        
        _topView = [[HJShopTopView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, 50)];
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
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [_collectionView registerClass:[HJShopCollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    
    return cell;
}


@end
