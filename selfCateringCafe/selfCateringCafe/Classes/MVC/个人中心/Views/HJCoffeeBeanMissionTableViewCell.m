//
//  HJCoffeeBeanMissionTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCoffeeBeanMissionTableViewCell.h"

@interface HJCoffeeBeanMissionTableViewCell()

/** 提示 */
@property (nonatomic,weak) HJLayoutBtn *alertBtn;

/** 描述 */
@property (nonatomic,weak) UILabel *detailLabel;

/** 按钮u */
@property (nonatomic,weak) UIButton *btn;

@end

@implementation HJCoffeeBeanMissionTableViewCell

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
    
    HJLayoutBtn *alertBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    alertBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    alertBtn.HJ_Spacing = 10;
    [alertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:alertBtn];
    [alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-5);
        make.left.offset(15);
    }];
    self.alertBtn = alertBtn;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    UILabel *detailLabel = [UILabel labelWithFontSize:14 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertBtn.mas_bottom).offset(10);
        make.left.equalTo(alertBtn.mas_left);
    }];
    self.detailLabel = detailLabel;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor colorWithHexString:@"#F17D86"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.height.offset(30);
        make.centerY.offset(0);
        make.width.offset(100);
    }];
    self.btn = btn;
    btn.layer.cornerRadius = 15.0f;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#F17D86"].CGColor;
    btn.layer.masksToBounds = YES;
    
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.alertBtn setImage:kGetImage(dic[@"image"]) forState:UIControlStateNormal];

    [self.alertBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
    
    self.detailLabel.text = dic[@"detail"];
    
    if ([dic[@"type"] integerValue] == 1) {
        
        [self.btn setTitle:@"签到" forState:UIControlStateNormal];
        
    }else if ([dic[@"type"] integerValue] == 2)
    {
        [self.btn setTitle:@"去完成" forState:UIControlStateNormal];

    }else if ([dic[@"type"] integerValue] == 3)
    {
        [self.btn setTitle:@"去分享" forState:UIControlStateNormal];

    }
    else
    {
        [self.btn setTitle:@"去查看" forState:UIControlStateNormal];
    }
    
    
}


-(void)setDataSource:(NSDictionary *)dataSource
{
    _dataSource = dataSource;
    
    if ([self.dic[@"type"] integerValue] == 1) {
        
        if ([dataSource[@"issign"] integerValue] == 1) {
            
            [self.btn setTitle:@"已签" forState:UIControlStateNormal];

        }else
        {
            [self.btn setTitle:@"签到" forState:UIControlStateNormal];

        }
        
    }
    
    
}

-(void)btnClick
{
    
    if (self.block) {
        
        self.block(self.dic);
    }
}



@end
