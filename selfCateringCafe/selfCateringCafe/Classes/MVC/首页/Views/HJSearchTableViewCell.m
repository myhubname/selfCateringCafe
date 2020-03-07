//
//  HJSearchTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJSearchTableViewCell.h"

@interface HJSearchTableViewCell()

/** 图片  */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** nameLabel */
@property (nonatomic,weak) UILabel *nameLabel;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 数量 */
@property (nonatomic,weak) UILabel *numLabel;

@end

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
    self.goodsImageView = goodsImageView;
    
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
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
        make.bottom.equalTo(goodsImageView.mas_bottom).offset(0);
        make.left.equalTo(nameLabel.mas_left);
    }];
    self.priceLabel = priceLabel;
    
    
    UILabel *numlabel = [UILabel labelWithFontSize:12 textColor:[UIColor colorWithHexString:@"#9d9c9c"]];
    [self.contentView addSubview:numlabel];
    [numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(priceLabel.mas_centerY);
    }];
    
    self.numLabel = numlabel;
    
}


-(void)setModel:(CourseModel *)model
{
    _model = model;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    self.nameLabel.text = model.topic;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    self.numLabel.text=  [NSString stringWithFormat:@"%@人已购买",model.sellcount];
    
}



@end
