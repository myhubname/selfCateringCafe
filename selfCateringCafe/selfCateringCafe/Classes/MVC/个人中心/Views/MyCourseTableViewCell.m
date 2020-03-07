//
//  MyCourseTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "MyCourseTableViewCell.h"

@interface MyCourseTableViewCell()

/** 商品图片 */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 商品名称  */
@property (nonatomic,weak) UILabel *nameLabel;

/** 描述 */
@property (nonatomic,weak) UILabel *miaoshuLabel;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 提示 */
@property (nonatomic,weak) UILabel *alertLabel;

@end

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
    self.goodsImageView = goodsImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(10);
        make.right.offset(-10);
        make.top.equalTo(goodsImageView.mas_top);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *miaoshu = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:miaoshu];
    [miaoshu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.right.offset(-10);
    }];
    self.miaoshuLabel = miaoshu;
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#E77068"]];
//    priceLabel.text = @"¥398.00";
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(miaoshu.mas_left);
        make.bottom.equalTo(goodsImageView.mas_bottom).offset(0);
    }];
    self.priceLabel = priceLabel;
    
    
    UILabel *alertlabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:alertlabel];
    [alertlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(priceLabel.mas_centerY).offset(0);
    }];
    self.alertLabel = alertlabel;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,dic[@"pic"]]] placeholder:kGetImage(squarePlaceholder)];
    
    self.nameLabel.text = dic[@"topic"];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
    
    if ([dic[@"status"] integerValue] == 2) {
        
        self.alertLabel.text = dic[@"stateText"];
        
    }else if ([dic[@"status"] integerValue] == 1)
    {
        
        
        self.alertLabel.text = [NSString stringWithFormat:@"%@,%@",dic[@"stateText"],@"去支付"];
        
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.alertLabel.text];
        
        NSRange range = [self.alertLabel.text rangeOfString:@"去支付"];
        
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        self.alertLabel.attributedText = attribute;
        
    }
    
    
}


@end
