//
//  ExcellentCoursesTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "ExcellentCoursesTableViewCell.h"

@interface ExcellentCoursesTableViewCell()

/** 商品图片 */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 标题  */
@property (nonatomic,weak) UILabel *nameLabel;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

@end

@implementation ExcellentCoursesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(120);
        make.height.offset(67);
        make.centerY.offset(0);
    }];
    self.goodsImageView = goodsImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(15);
        make.top.equalTo(goodsImageView.mas_top);
        make.right.offset(-15);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#fd3528"]];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.bottom.equalTo(goodsImageView.mas_bottom).offset(0);
    }];
    self.priceLabel = priceLabel;
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#dbdada"];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.8);
        make.bottom.offset(0);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,dic[@"pic"]]] placeholder:kGetImage(squarePlaceholder)];
    
    
    self.nameLabel.text = dic[@"topic"];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
}


@end
