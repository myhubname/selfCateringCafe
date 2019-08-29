//
//  HJLoginRegistAlert.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJLoginRegistAlert.h"

@implementation HJLoginRegistAlert

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    UILabel *centerLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#999999"]];
    centerLabel.text = @"没有账号去注册";
    [self addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset(0);
    }];
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc] initWithString:centerLabel.text];
    NSRange range = [centerLabel.text rangeOfString:@"注册"];
    [attributStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#fd443f"] range:range];
    centerLabel.attributedText = attributStr;
 
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#818181"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerLabel.mas_left).offset(-15);
        make.centerY.equalTo(centerLabel.mas_centerY);
        make.width.offset(80);
        make.height.offset(1);
    }];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"#818181"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerLabel.mas_right).offset(15);
        make.centerY.equalTo(centerLabel.mas_centerY);
        make.width.offset(80);
        make.height.offset(1);
    }];

}


@end
