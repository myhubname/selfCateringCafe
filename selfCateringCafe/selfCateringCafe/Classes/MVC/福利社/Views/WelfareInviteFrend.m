//
//  WelfareInviteFrend.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/28.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "WelfareInviteFrend.h"
#import "HJProgressView.h"
@implementation WelfareInviteFrend

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.image = kGetImage(@"fulibg");
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *alertImageView = [[UIImageView alloc] init];
    alertImageView.image = kGetImage(@"inviteAlert");
    [self addSubview:alertImageView];
    [alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(35);
        make.centerX.offset(0);
        make.width.offset(205);
        make.height.offset(12);
    }];
    
    UILabel  *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    alertLabel.font = [UIFont boldSystemFontOfSize:18];
    alertLabel.text = @"立享价值399元/月获取VIP学员资格 ";
    [self addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertImageView.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:alertLabel.text];
    NSRange range = [alertLabel.text rangeOfString:@"399"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff452c"] range:range];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:range];
    NSRange alertRange = [alertLabel.text rangeOfString:@"元/月"];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:alertRange];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff452c"] range:alertRange];
    alertLabel.attributedText = attributeStr;
    
    
    UIButton *alertOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertOneBtn setBackgroundImage:kGetImage(@"alertImageIcon") forState:UIControlStateNormal];
    [alertOneBtn setTitle:@"已直接邀请2人成为会员，还差3人" forState:UIControlStateNormal];
    alertOneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    alertOneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:alertOneBtn];
    [alertOneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertLabel.mas_bottom).offset(15);
        make.left.offset(45);
        make.right.offset(-50);
        make.height.offset(30);
    }];
    
    HJProgressView *progressOne = [[HJProgressView alloc] init];
    progressOne.progress = 0.3;
    [self addSubview:progressOne];
    [progressOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(SCREEN_WIDTH-120);
        make.top.equalTo(alertOneBtn.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
    progressOne.layer.cornerRadius = 7.5f;
    progressOne.layer.masksToBounds = YES;
    
    
    UIButton *alertTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertTwoBtn setBackgroundImage:kGetImage(@"alertImageIcon") forState:UIControlStateNormal];
    [alertTwoBtn setTitle:@"已邀请会员团队总业绩462元，还差105元" forState:UIControlStateNormal];
    alertTwoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    alertTwoBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:alertTwoBtn];
    [alertTwoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressOne.mas_bottom).offset(15);
        make.left.offset(45);
        make.right.offset(-50);
        make.height.offset(30);
    }];
    
    HJProgressView *progressTwo = [[HJProgressView alloc] init];
    progressTwo.progress = 0.8;
    [self addSubview:progressTwo];
    [progressTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(SCREEN_WIDTH-120);
        make.top.equalTo(alertTwoBtn.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
    progressTwo.layer.cornerRadius = 7.5f;
    progressTwo.layer.masksToBounds = YES;
    
    
    
    UIButton *LocalTyranBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LocalTyranBtn setImage:kGetImage(@"LocalTyrantUpgradeIcon") forState:UIControlStateNormal];
    [self addSubview:LocalTyranBtn];
    [LocalTyranBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(116);
        make.height.offset(44);
        make.centerX.offset(-58);
        make.bottom.offset(-30);
    }];

    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inviteBtn setImage:kGetImage(@"InvitingNowIcon") forState:UIControlStateNormal];
    [self addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(LocalTyranBtn.mas_width);
        make.height.offset(44);
        make.centerX.offset(58);
        make.bottom.equalTo(LocalTyranBtn);
    }];
    

}



@end
