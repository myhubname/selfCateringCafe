//
//  HJShopCollectionViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJShopCollectionViewCell.h"

@interface HJShopCollectionViewCell()

/** 商品图片 */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 商品名称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 价格  */
@property (nonatomic,weak) UILabel *priceLabel;

@end

@implementation HJShopCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset((SCREEN_WIDTH-30)/2);
    }];
    self.goodsImageView = goodsImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.equalTo(goodsImageView.mas_bottom).offset(5);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#fc4345"]];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.bottom.offset(-5);
    }];
    self.priceLabel = priceLabel;
    
//    UILabel *numLabel = [UILabel labelWithFontSize:12 textColor:[UIColor colorWithHexString:@"#999999"]];
//    numLabel.text = @"216人购买";
//    [self.contentView addSubview:numLabel];
//    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-5);
//        make.bottom.offset(-5);
//
//    }];
}

-(void)setModel:(ShopModel *)model
{
    _model = model;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    
    self.nameLabel.text = model.topic;
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"所需积分%@分",model.integral];
    
}


@end
