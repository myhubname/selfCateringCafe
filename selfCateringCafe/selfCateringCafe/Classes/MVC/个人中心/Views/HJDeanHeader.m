//
//  HJDeanHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJDeanHeader.h"

@implementation HJDeanHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI
{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#2c2b39"];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(SCREEN_WIDTH+200);
        make.top.offset(-SCREEN_WIDTH/2-200);
        make.centerX.offset(0);
    }];
    bgView.layer.cornerRadius = (SCREEN_WIDTH+200)/2;
    bgView.layer.masksToBounds = YES;
    
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = kGetImage(@"VipBg");
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(150);
        make.centerY.equalTo(bgView.mas_bottom).offset(-30);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.backgroundColor = [UIColor greenColor];
    [bgImageView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.height.offset(70);
        make.top.offset(20);
    }];
    iconImageView.layer.cornerRadius = 35.0f;
    iconImageView.layer.masksToBounds = YES;
    

    UILabel *nameLabel = [UILabel labelWithFontSize:14 textColor:[UIColor colorWithHexString:@"#444154"]];
    nameLabel.text = @"13089567755";
    [bgImageView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(10);
        make.centerY.equalTo(iconImageView.mas_centerY).offset(-15);
    }];
    
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor colorWithHexString:@"#21212d"];
    [bgImageView addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.height.offset(25);
        make.width.offset(80);
    }];
    alertView.layer.cornerRadius = 12.5f;
    alertView.layer.masksToBounds = YES;
    
    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#f0e8d3"]];
    alertLabel.text = @"高级会员";
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset(0);
    }];
    
    
    UIImageView *alertImageView = [UIImageView initImageView];
    alertImageView.image = kGetImage(@"vipAlert");
    [self addSubview:alertImageView];
    [alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_bottom).offset(20);
        make.width.offset(287);
        make.height.offset(32);
        make.centerX.offset(0);
    }];
    
    
}



@end
