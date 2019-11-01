//
//  HJSearchTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJSearchTableViewCell.h"

@implementation HJSearchTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *goodsImageView = [UIImageView initImageView];
    goodsImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.width.offset(120);
        make.height.offset(90);
    }];
    
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    nameLabel.text = @"淘宝新规下如何快速形成店铺爆 款，免费流量飙升";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(15);
        make.top.equalTo(goodsImageView.mas_top);
        make.right.offset(-15);
    }];
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#fd3528"]];
    priceLabel.text = @"￥398.00";
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(goodsImageView.mas_bottom).offset(0);
        make.left.equalTo(nameLabel.mas_left);
    }];
    
    
    
    UILabel *numlabel = [UILabel labelWithFontSize:12 textColor:[UIColor colorWithHexString:@"#9d9c9c"]];
    numlabel.text = @"103人已购买";
    [self.contentView addSubview:numlabel];
    [numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(priceLabel.mas_centerY);
    }];
    
    
    
}



@end
