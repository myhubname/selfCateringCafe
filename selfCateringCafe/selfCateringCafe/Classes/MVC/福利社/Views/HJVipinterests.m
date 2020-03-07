//
//  HJVipinterests.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJVipinterests.h"

@interface HJVipinterests()<UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HJVipinterests

static NSString *const identifer = @"identifer";

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.image = kGetImage(@"fulibg");

        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *vipImageView = [[UIImageView alloc] init];
    vipImageView.image = kGetImage(@"VipinterestsIcon");
    [self addSubview:vipImageView];
    [vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(30);
        make.width.offset(118);
        make.height.offset(20);
    }];
    
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipImageView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowYout = [[UICollectionViewFlowLayout alloc] init];
        flowYout.minimumLineSpacing = 15;
        flowYout.minimumInteritemSpacing = 15;
        flowYout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowYout.itemSize = CGSizeMake((SCREEN_WIDTH-80)/3, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowYout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[vipCollectionCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.vipArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    vipCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.iconImageView.image = kGetImage(self.vipArray[indexPath.item][@"image"]);
    
    cell.nameLabel.text = self.vipArray[indexPath.item][@"name"];
    
    cell.desLabel.text = self.vipArray[indexPath.item][@"des"];
    
    return cell;
}

-(void)setVipArray:(NSArray *)vipArray
{
    _vipArray = vipArray;
    
    [self.collectionView reloadData];
}

@end

@implementation vipCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10);
        make.width.height.offset(51);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *nameLbael = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLbael];
    [nameLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
    }];
    self.nameLabel = nameLbael;
    
    UILabel *desLabel = [UILabel labelWithFontSize:12 textColor:[UIColor colorWithHexString:@"#9f9f9f"]];
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(nameLbael.mas_bottom).offset(5);
    }];
    self.desLabel = desLabel;
}


@end
