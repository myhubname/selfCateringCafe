//
//  PersonalHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "PersonalHeader.h"

@interface PersonalHeader()

/** 头像 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** phoneLabel */
@property (nonatomic,weak) UILabel *phoneLabel;

/** 收益 */
@property (nonatomic,weak) UILabel *moneyLabel;

@end

@implementation PersonalHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    UIImageView *headerView = [[UIImageView alloc] init];
    headerView.image = kGetImage(@"percenterBg");
    headerView.userInteractionEnabled = YES;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(280);
    }];
    
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [headerView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(TopHeight+15);
        make.width.height.offset(50);
    }];
    self.iconImageView = iconImageView;
    iconImageView.layer.cornerRadius = 25.0f;
    iconImageView.layer.masksToBounds = YES;
    
    
    UILabel *phoneLabel = [UILabel labelWithFontSize:15 textColor:[UIColor whiteColor]];
    [headerView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImageView.mas_centerY);
        make.left.equalTo(iconImageView.mas_right).offset(15);
    }];
    self.phoneLabel = phoneLabel;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"咖啡豆商城>" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor colorWithHexString:@"#ff5b56"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(shopClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(iconImageView.mas_centerY).offset(0);
        make.width.offset(100);
        make.height.offset(30);
    }];
    btn.layer.cornerRadius = 15.0f;
    btn.layer.masksToBounds = YES;
    
   
    UIView *oneView = [[UIView alloc] init];
    [headerView addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset((SCREEN_WIDTH-3)/3);
        make.height.offset(50);
        make.bottom.offset(-40);
    }];
    
    UILabel *teamNum = [UILabel labelWithFontSize:15 textColor:[UIColor whiteColor]];
    teamNum.text = @"0";
    teamNum.font = [UIFont boldSystemFontOfSize:16];
    [oneView addSubview:teamNum];
    [teamNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(0);
    }];
    
    UILabel *teamAlertLabel = [UILabel labelWithFontSize:14 textColor:[UIColor whiteColor]];
    teamAlertLabel.text = @"直属团队";
    [oneView addSubview:teamAlertLabel];
    [teamAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.centerX.offset(0);
    }];
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.left.equalTo(oneView.mas_right);
        make.height.offset(50);
        make.bottom.offset(-40);
    }];
    
    

    UIView *towView = [[UIView alloc] init];
    [headerView addSubview:towView];
    [towView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right);
        make.width.offset((SCREEN_WIDTH-3)/3);
        make.height.offset(50);
        make.bottom.offset(-40);
    }];

    UILabel *subordinateNumLabel = [UILabel labelWithFontSize:15 textColor:[UIColor whiteColor]];
    subordinateNumLabel.text = @"0";
    subordinateNumLabel.font = [UIFont boldSystemFontOfSize:15];
    [towView addSubview:subordinateNumLabel];
    [subordinateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(0);
    }];
    
    UILabel *subAlertLabel = [UILabel labelWithFontSize:14 textColor:[UIColor whiteColor]];
    subAlertLabel.text = @"直属团队下级";
    [towView addSubview:subAlertLabel];
    [subAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    
    UIView *twoLine = [[UIView alloc] init];
    twoLine.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:twoLine];
    [twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(towView.mas_right).offset(0);
        make.width.offset(1);
        make.height.offset(50);
        make.bottom.offset(-40);
    }];
    
    
    UIView *thirdView = [[UIView alloc] init];
    [headerView addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoLine.mas_right).offset(0);
        make.bottom.offset(-40);
        make.right.offset(0);
        make.height.offset(50);
    }];
    
    
    UILabel *moneyLabel = [UILabel labelWithFontSize:15 textColor:[UIColor whiteColor]];
    moneyLabel.text = @"0.00";
    moneyLabel.font = [UIFont boldSystemFontOfSize:15];
    [thirdView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(0);
    }];
    self.moneyLabel = moneyLabel;
    
    UILabel *moneyAlertLabel = [UILabel labelWithFontSize:14 textColor:[UIColor whiteColor]];
    moneyAlertLabel.text = @"累计收益";
    [thirdView addSubview:moneyAlertLabel];
    [moneyAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    
    
    UIView *vipView = [[UIView alloc] init];
    vipView.backgroundColor = [UIColor whiteColor];
    [self addSubview:vipView];
    [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
        make.top.equalTo(headerView.mas_bottom).offset(-20);
    }];
    vipView.layer.cornerRadius = 20.0f;
    vipView.layer.masksToBounds = YES;
    
    UIImageView *vipImageView = [[UIImageView alloc] initWithImage:kGetImage(@"VipIcon")];
    [vipView addSubview:vipImageView];
    [vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.width.offset(19);
        make.height.offset(18);
    }];
    
    UILabel *vipLabel = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    vipLabel.text = @"高级会员";
    [vipView addSubview:vipLabel];
    [vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipImageView.mas_right).offset(0);
        make.centerY.offset(0);
    }];
    
    
    HJLayoutBtn *rightBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:kGetImage(@"rightArrowIcon") forState:UIControlStateNormal];
    rightBtn.HJ_Style = HJLaoutBtnStyleImageRight;
    [rightBtn setTitle:@"升级院长" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.userInteractionEnabled = NO;
    [vipView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
    __weak typeof(self)weakself = self;
    [vipView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if (weakself.goToYuanClick) {
            
            weakself.goToYuanClick();
        }
    }];
    
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    

    [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,dic[@"userface"]]] placeholder:kGetImage(@"UserPlaceIcon")];
    
    
    self.phoneLabel.text = dic[@"user"];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",dic[@"brokerageamount"]];
    
    
}


-(void)shopClick
{
    if (self.block) {
        
        self.block();
    }
    
    
}



@end
