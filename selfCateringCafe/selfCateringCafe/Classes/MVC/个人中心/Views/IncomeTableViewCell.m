//
//  IncomeTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/18.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "IncomeTableViewCell.h"

@implementation IncomeTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UILabel *withdrawIngLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    withdrawIngLabel.textAlignment = NSTextAlignmentCenter;
    withdrawIngLabel.numberOfLines = 0;
    withdrawIngLabel.text = [NSString stringWithFormat:@"%@\n\n%@",@"正在提现中(元)",@"0.00"];
    [self.contentView addSubview:withdrawIngLabel];
    [withdrawIngLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(SCREEN_WIDTH/2);
        make.top.bottom.offset(0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(withdrawIngLabel.mas_right).offset(0);
        make.top.offset(15);
        make.bottom.offset(-15);
        make.width.offset(1);
    }];
    
    UILabel *withdrawLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    withdrawLabel.textAlignment = NSTextAlignmentCenter;
    withdrawLabel.numberOfLines = 0;
    withdrawLabel.text = [NSString stringWithFormat:@"%@\n\n%@",@"可提现余额(元)",@"0.00"];
    [self.contentView addSubview:withdrawLabel];
    [withdrawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(0);
        make.width.equalTo(withdrawIngLabel.mas_width);
        make.top.bottom.offset(0);
    }];
    
}




@end
