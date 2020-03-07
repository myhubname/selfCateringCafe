//
//  HJCashRecordTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2020/1/11.
//  Copyright © 2020 胡俊杰. All rights reserved.
//

#import "HJCashRecordTableViewCell.h"

@interface HJCashRecordTableViewCell()

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

/** state */
@property (nonatomic,weak) UILabel *stateLabel;

@end

@implementation HJCashRecordTableViewCell

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
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:12 textColor:[UIColor redColor]];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
        make.left.equalTo(nameLabel.mas_left);
    }];
    self.priceLabel = priceLabel;
    

    UILabel *timeLabel = [UILabel labelWithFontSize:10 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(nameLabel.mas_centerY);
    }];
    self.timeLabel = timeLabel;

    
    UILabel *stateLabel = [UILabel labelWithFontSize:10 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(priceLabel.mas_centerY);
    }];
    self.stateLabel = stateLabel;
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    self.nameLabel.text = dic[@"type"];
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"提现金额:%@",dic[@"price"]];
    
    
    self.timeLabel.text = dic[@"date"];
    
    
    if ([dic[@"status"] integerValue] == 0) {
        
        self.stateLabel.text = @"未审核";
    }else if ([dic[@"status"] integerValue] == 1)
    {
        self.stateLabel.text = @"审核成功";
    }else if ([dic[@"status"] integerValue] == 2)
    {
        self.stateLabel.text = [NSString stringWithFormat:@"审核失败:%@",dic[@"failmark"]];
    }
    
    
}


@end
