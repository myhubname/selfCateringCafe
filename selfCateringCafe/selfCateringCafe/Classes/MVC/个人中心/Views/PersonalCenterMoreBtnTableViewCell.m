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
    [orderBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(92);
        make.height.offset(63);
        make.left.offset(sapce);
        make.centerY.offset(0);
    }];

    UIButton *teamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teamBtn setImage:kGetImage(@"MyTeam") forState:UIControlStateNormal];
    [teamBtn addTarget:self action:@selector(myTeamClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:teamBtn];
    [teamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderBtn.mas_right).offset(sapce);
        make.width.offset(92);
        make.height.offset(63);
        make.centerY.offset(0);
    }];
    
    
    
    UIButton *teamMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    [teamMoney setImage:kGetImage(@"TeamBenefit") forState:UIControlStateNormal];
    [teamMoney addTarget:self action:@selector(teamMoneyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:teamMoney];
    [teamMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(teamBtn.mas_right).offset(sapce);
        make.width.offset(92);
        make.height.offset(63);
        make.centerY.offset(0);
    }];
    
    
}

#pragma mark-推广订单
-(void)orderClick
{
    if (self.moreBtnBlock) {
        
        self.moreBtnBlock(1);
    }

}
#pragma mark-我的团队
-(void)myTeamClick
{
    if (self.moreBtnBlock) {
        
        self.moreBtnBlock(2);
    }
}

#pragma mark-团队收益
-(void)teamMoneyClick
{
    if (self.moreBtnBlock) {
        
        self.moreBtnBlock(3);
    }
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 20;
    frame.size.width -= 40;
    
    [super setFrame:frame];
}



@end
