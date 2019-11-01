//
//  MyCourseTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "MyCourseTableViewCell.h"

@implementation MyCourseTableViewCell

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
    goodsImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(120);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.left.offset(10);
    }];
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    nameLabel.text = @"淘宝新规下如何快速形成店铺爆m";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(10);
        make.right.offset(-10);
        make.top.equalTo(goodsImageView.mas_top);
    }];
    
    UILabel *miaoshu = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    miaoshu.text = @"爆款课程一年课程零基础也可以学习";
    [self.contentView addSubview:miaoshu];
    [miaoshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.right.offset(-10);
    }];
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#E77068"]];
    priceLabel.text = @"¥398.00";
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(miaoshu.mas_left);
        make.bottom.equalTo(goodsImageView.mas_bottom).offset(0);
    }];
    
    
    UILabel *alertlabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    alertlabel.text = @"已购买";
    [self.contentView addSubview:alertlabel];
    [alertlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(priceLabel.mas_centerY).offset(0);
    }];
    
    
}




@end
