//
//  HJMoreClassTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJMoreClassTableViewCell.h"

@interface HJMoreClassTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;


@end

@implementation HJMoreClassTableViewCell
static NSString *const identifer = @"identifer";

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
    }
    return self;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowYout = [[UICollectionViewFlowLayout alloc] init];
        flowYout.itemSize = CGSizeMake((SCREEN_WIDTH-75)/4, 90);
        flowYout.minimumLineSpacing = 15;
        flowYout.minimumInteritemSpacing = 15;
        flowYout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowYout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[HJMoreClassCollectionCell class] forCellWithReuseIdentifier:identifer];
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
    HJMoreClassCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];

    cell.logoImageView.image = kGetImage(self.dataArray[indexPath.item][@"image"]);
    
    cell.nameLabel.text = self.dataArray[indexPath.row][@"name"];
    
    return cell;
    
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.classBlock) {
        
        self.classBlock(self.dataArray[indexPath.row]);
    }
    
}


@end

@implementation HJMoreClassCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(42);
        make.centerX.offset(0);
        make.centerY.offset(-10);
    }];
    self.logoImageView = logoImageView;
    
    
    UILabel *nameLabel = [UILabel labelWithFontSize:14 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(logoImageView.mas_bottom).offset(5);
    }];
    self.nameLabel = nameLabel;
}



@end
