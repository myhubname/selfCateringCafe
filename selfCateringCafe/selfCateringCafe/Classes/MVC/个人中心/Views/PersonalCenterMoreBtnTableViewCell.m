//
//  PersonalCenterMoreBtnTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "PersonalCenterMoreBtnTableViewCell.h"

@implementation PersonalCenterMoreBtnTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.layer.cornerRadius = 5.0f;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.masksToBounds = YES;
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    CGFloat sapce = ((SCREEN_WIDTH-40) - (92 *3))/4;
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setImage:kGetImage(@"PromotionOrders") forState:UIControlStateNormal];
    [self.contentView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(92);
        make.height.offset(63);
        make.left.offset(sapce);
        make.centerY.offset(0);
    }];

    UIButton *teamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teamBtn setImage:kGetImage(@"MyTeam") forState:UIControlStateNormal];
    [self.contentView addSubview:teamBtn];
    [teamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderBtn.mas_right).offset(sapce);
        make.width.offset(92);
        make.height.offset(63);
        make.centerY.offset(0);
    }];
    
    
    
    UIButton *teamMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    [teamMoney setImage:kGetImage(@"TeamBenefit") forState:UIControlStateNormal];
    [self.contentView addSubview:teamMoney];
    [teamMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(teamBtn.mas_right).offset(sapce);
        make.width.offset(92);
        make.height.offset(63);
        make.centerY.offset(0);
    }];
    
    
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 20;
    frame.size.width -= 40;
    
    [super setFrame:frame];
}



@end
