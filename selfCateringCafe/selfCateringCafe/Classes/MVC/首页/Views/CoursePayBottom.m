//
//  CoursePayBottom.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/10.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "CoursePayBottom.h"

@implementation CoursePayBottom

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UILabel *priceLabel = [UILabel labelWithFontSize:16 textColor:[UIColor colorWithHexString:@"#ee3a3e"]];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.backgroundColor = [UIColor colorWithHexString:@"#fde2e3"];
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.bottom.offset(0);
        make.width.offset(SCREEN_WIDTH-SCREEN_WIDTH/2+30);
    }];
    self.priceLabel = priceLabel;
    
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[UIColor colorWithHexString:@"#ee3a3e"]];
    [buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.right.offset(0);
        make.width.offset(SCREEN_WIDTH/2-30);
    }];
    self.buyButton = buyBtn;
    
    
}

-(void)buyClick
{
    if (self.buyBlock) {
        
        self.buyBlock();
    }
    
}


@end
