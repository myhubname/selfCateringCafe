//
//  HJProOrderHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/17.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJProOrderHeader.h"

@interface HJProOrderHeader()

/** 头像 */
@property (nonatomic,weak) UIImageView *userFace;

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

/** 邀请码 */
@property (nonatomic,weak) UILabel *inviteLabel;

@end


@implementation HJProOrderHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *userFace = [[UIImageView alloc] init];
    [self.contentView addSubview:userFace];
    [userFace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.width.offset(60);
        make.centerY.offset(0);
    }];
    self.userFace = userFace;
    
    
    UILabel *namelabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userFace.mas_right).offset(10);
        make.top.equalTo(userFace.mas_top).offset(0);
    }];
    self.nameLabel = namelabel;
    
    
    UILabel *timeLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namelabel.mas_left);
        make.bottom.equalTo(userFace.mas_bottom).offset(0);
    }];
    self.timeLabel = timeLabel;
    
    UILabel *inviteLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:inviteLabel];
    [inviteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(timeLabel.mas_centerY).offset(0);
    }];
    self.inviteLabel = inviteLabel;
    
    
}


-(void)setModel:(HJProOrderModel *)model
{
    _model = model;
    
    
//    [self.userFace setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.userface]] placeholder:kGetImage(squarePlaceholder)];
//
//
//
//    self.nameLabel.text = model.phone;
//
//    self.timeLabel.text = model.order_time;
    
//    self.inviteLabel.text = [NSString stringWithFormat:@"邀请码:%@",model.usernumber];
    
}



@end
