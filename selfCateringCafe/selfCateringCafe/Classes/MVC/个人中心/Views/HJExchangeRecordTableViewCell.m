//
//  HJExchangeRecordTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/20.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJExchangeRecordTableViewCell.h"

@interface HJExchangeRecordTableViewCell()

/** 图片 */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 商品名称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 订单号 */
@property (nonatomic,weak) UILabel *snLabel;

/** 积分 */
@property (nonatomic,weak) UILabel *interLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

@end

@implementation HJExchangeRecordTableViewCell

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
        make.left.offset(15);
        make.height.width.offset(100);
        make.centerY.offset(0);
    }];
    self.goodsImageView = goodsImageView;
    
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#58acdd"]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsImageView.mas_top);
        make.left.equalTo(goodsImageView.mas_right).offset(10);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *snLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:snLabel];
    [snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
    }];
    self.snLabel = snLabel;
    
    
    UILabel *interLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:interLabel];
    [interLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snLabel.mas_bottom).offset(10);
        make.left.equalTo(snLabel.mas_left);
    }];
    self.interLabel = interLabel;
    
    
    UILabel *timeLable = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    
    [self.contentView addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(interLabel.mas_bottom).offset(10);
    }];
    
    self.timeLabel = timeLable;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
    
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApiPrefix,dic[@"pic"]]] placeholder:kGetImage(squarePlaceholder)];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"goods_name"]];
    
    self.snLabel.text = [NSString stringWithFormat:@"订单号:%@",dic[@"order_sn"]];
    
    
    self.interLabel.text = [NSString stringWithFormat:@"消耗积分:%@积分",dic[@"goods_point"]];

    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.interLabel.text];
    
    NSRange range = [self.interLabel.text rangeOfString:[NSString stringWithFormat:@"%@",dic[@"goods_point"]]];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    self.interLabel.attributedText = attribute;
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"兑换时间:%@",dic[@"order_time"]];
}


@end
