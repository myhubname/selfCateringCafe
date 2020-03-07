//
//  HJProOrderTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJProOrderTableViewCell.h"

@interface HJProOrderTableViewCell()

/** 电话 */
@property (nonatomic,weak) UILabel *phoneLabel;

/** 订单号 */
@property (nonatomic,weak) UILabel *snLabel;

/** 商品图片  */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 商品名称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 商品价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

@end

@implementation HJProOrderTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    UILabel *phoneLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    self.phoneLabel = phoneLabel;
    
    UILabel *snLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#f65a5c"]];
    [self.contentView addSubview:snLabel];
    [snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(phoneLabel.mas_centerY);
    }];
    self.snLabel = snLabel;
    
    UIImageView *goodsImageView = [UIImageView initImageView];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(phoneLabel.mas_bottom).offset(10);
        make.height.width.offset(100);
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
    self.nameLabel  = nameLabel;

    UILabel *priceLabel = [UILabel labelWithFontSize:15 textColor:[UIColor redColor]];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.bottom.equalTo(goodsImageView.mas_bottom);
    }];
    self.priceLabel = priceLabel;
    
    
    UILabel *timeLabel = [UILabel labelWithFontSize:15 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(priceLabel.mas_centerY);
    }];
    
    self.timeLabel = timeLabel;
    
}


-(void)setModel:(HJProOrderModel *)model
{
    _model = model;
    
    self.phoneLabel.text = [NSString stringWithFormat:@"%@(%@)",model.phone,model.usernumber];
    
    
    self.snLabel.text = model.sn;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:model.topic];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8.0; // 设置行间距
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attribute.length)];

    self.nameLabel.attributedText = attribute;

    self.priceLabel.text = [NSString stringWithFormat:@"¥%@元",model.price];
    
    self.timeLabel.text = model.paytime;
    
}




@end
