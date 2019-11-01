//
//  HJDeanTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJDeanTableViewCell.h"

@implementation HJDeanTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI
{
    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor whiteColor]];
    alertLabel.backgroundColor = [UIColor colorWithHexString:@"#e3b697"];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(20);
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    alertLabel.layer.cornerRadius = 10.0f;
    alertLabel.layer.masksToBounds = YES;
    self.alertLabel = alertLabel;
    
    UILabel *connentLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:connentLabel];
    [connentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertLabel.mas_right).offset(15);
        make.centerY.offset(0);
    }];
    
    self.connentLabel = connentLabel;
}




@end
