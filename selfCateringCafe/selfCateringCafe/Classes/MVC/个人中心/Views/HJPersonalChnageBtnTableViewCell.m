//
//  HJPersonalChnageBtnTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJPersonalChnageBtnTableViewCell.h"

@interface HJPersonalChnageBtnTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;



@end

@implementation HJPersonalChnageBtnTableViewCell
static NSString *const identifer = @"identifer";

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        flowYout.itemSize = CGSizeMake((SCREEN_WIDTH-40)/4, 90);
        flowYout.minimumLineSpacing = 0;
        flowYout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowYout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoreBtnCollectionCell class] forCellWithReuseIdentifier:identifer];
    }
    
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MoreBtnCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
   
 
    [cell.iconImageView setImage:kGetImage(self.dataArray[indexPath.item][@"image"])];
    
    cell.nameLabel.text = self.dataArray[indexPath.item][@"name"];
    
    return cell;
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    
    [self.collectionView reloadData];
}



-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 20;
    
    frame.size.width -= 40;
    
    [super setFrame:frame];
}


@end
@implementation MoreBtnCollectionCell


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
        make.centerY.offset(-7.5);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
    }];
    self.nameLabel = nameLabel;
}



@end
