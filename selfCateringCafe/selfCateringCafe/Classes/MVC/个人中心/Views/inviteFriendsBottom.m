//
//  inviteFriendsBottom.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "inviteFriendsBottom.h"

@implementation inviteFriendsBottom


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    HJLayoutBtn *shareLinkBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [shareLinkBtn setBackgroundImage:kGetImage(@"shareLink") forState:UIControlStateNormal];
    shareLinkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareLinkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareLinkBtn setTitle:@"分享邀请链接" forState:UIControlStateNormal];
    shareLinkBtn.adjustsImageWhenHighlighted = NO;
    [shareLinkBtn addTarget:self action:@selector(sharLinkeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareLinkBtn];
    [shareLinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.height.offset(45);
        make.width.offset(SCREEN_WIDTH/2);
        make.bottom.offset(0);
    }];
    
    
    HJLayoutBtn *sharePic = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [sharePic setBackgroundImage:kGetImage(@"sharePic") forState:UIControlStateNormal];
    [sharePic setTitle:@"分享专属海报" forState:UIControlStateNormal];
    sharePic.titleLabel.font = [UIFont systemFontOfSize:15];
    [sharePic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sharePic.adjustsImageWhenHighlighted = NO;
    [sharePic addTarget:self action:@selector(sharePicClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sharePic];
    [sharePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareLinkBtn.mas_right);
        make.right.offset(0);
        make.height.offset(45);
        make.bottom.equalTo(shareLinkBtn);
    }];

    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    alertLabel.text = @"我的专属邀请码";
    [self addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10);
    }];
    

    UILabel *numLabel = [UILabel labelWithFontSize:25 textColor:[UIColor colorWithHexString:@"#fe0100"]];
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(alertLabel.mas_bottom).offset(15);
    }];
    self.inviteNumLabel = numLabel;
    
}

-(void)sharLinkeClick
{
    if (self.ShareBlock) {
        
        self.ShareBlock(0);
    }
    
}

-(void)sharePicClick
{
    if (self.ShareBlock) {
        
        self.ShareBlock(1);
    }
    
}


@end
