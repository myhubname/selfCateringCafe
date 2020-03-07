//
//  HJTeamTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/12.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJTeamTableViewCell.h"

@interface HJTeamTableViewCell()

/** 头像 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 账号 */
@property (nonatomic,weak) UILabel *phoneLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

/** 邀请码 */
@property (nonatomic,weak) UILabel *inviteNumLabel;

@end

@implementation HJTeamTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        [self creatUI];
        
    }
    
    return self;
}

-(void)creatUI
{
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.height.width.offset(60);
    }];
    iconImageView.layer.cornerRadius = 30.0f;
    iconImageView.layer.masksToBounds = YES;
    self.iconImageView = iconImageView;
    
    
    UILabel *phoneLabel = [UILabel labelWithFontSize:14 textColor:[UIColor blackColor]];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(10);
        make.top.equalTo(iconImageView.mas_top).offset(0);
    }];
    self.phoneLabel = phoneLabel;
    
    UILabel *timeLabel = [UILabel labelWithFontSize:14 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_left);
        make.bottom.equalTo(iconImageView.mas_bottom).offset(0);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *inviteNumLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    
    [self.contentView addSubview:inviteNumLabel];
    
    [inviteNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(timeLabel.mas_centerY);
    }];
    self.inviteNumLabel = inviteNumLabel;
    
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
    
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,dic[@"userface"]]] placeholder:kGetImage(squarePlaceholder)];
    
    self.phoneLabel.text = dic[@"phone"];
    
    self.timeLabel.text = dic[@"reg_time"];
    
    self.inviteNumLabel.text = [NSString stringWithFormat:@"邀请码：%@",dic[@"usernumber"]];
}



@end
